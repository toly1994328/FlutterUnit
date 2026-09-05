import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_env/unit_env.dart';

import '../model/progression_item.dart';
import '../repository/progression_repository.dart';

/// 当前用户任务与成就页面状态。
class ProgressionState {
  const ProgressionState({
    this.overview,
    this.loading = false,
    this.checkingIn = false,
    this.claimingCode,
    this.error,
  });

  /// 最近一次加载成功的总览。
  final ProgressionOverview? overview;

  /// 是否正在加载总览。
  final bool loading;

  /// 是否正在提交签到。
  final bool checkingIn;

  /// 当前正在领取奖励的任务编码。
  final String? claimingCode;

  /// 最近一次请求错误。
  final String? error;

  /// 当前已完成但尚未领取奖励的每日任务数量。
  int get claimableTaskCount =>
      overview?.dailyTasks
          .where((ProgressionItem item) => item.claimable)
          .length ??
      0;
}

/// 维护当前用户的每日任务、签到和长期成就状态。
class ProgressionCubit extends Cubit<ProgressionState> {
  ProgressionCubit(this._repository) : super(const ProgressionState());

  /// 任务与成就数据仓库。
  final ProgressionRepository _repository;

  /// 从服务端刷新总览，并在失败时保留旧数据。
  Future<void> load() async {
    emit(ProgressionState(overview: state.overview, loading: true));
    final ApiRet<ProgressionOverview> result = await _repository.loadOverview();
    if (!result.success) {
      emit(ProgressionState(overview: state.overview, error: result.msg));
      return;
    }
    emit(ProgressionState(overview: result.data));
  }

  /// 领取任务奖励，服务端账本保证重复请求不会重复增加匠尘。
  Future<void> claimDailyTask(String code) async {
    if (state.claimingCode != null) return;
    emit(ProgressionState(
      overview: state.overview,
      claimingCode: code,
    ));
    final ApiRet<ProgressionOverview> result =
        await _repository.claimDailyTask(code);
    if (!result.success) {
      emit(ProgressionState(overview: state.overview, error: result.msg));
      return;
    }
    emit(ProgressionState(overview: result.data));
  }

  /// 请求服务端签到并使用响应直接刷新全部进度。
  Future<bool> checkIn() async {
    if (state.checkingIn) return false;
    emit(ProgressionState(
      overview: state.overview,
      checkingIn: true,
    ));
    final ApiRet<ProgressionOverview> result = await _repository.checkIn();
    if (!result.success) {
      emit(ProgressionState(overview: state.overview, error: result.msg));
      return false;
    }
    emit(ProgressionState(overview: result.data));
    return true;
  }

  /// 记录组件详情访问；后台静默失败，不影响组件页面。
  Future<void> recordWidgetView(int widgetId) async {
    final ApiRet<bool> result = await _repository.recordWidgetView(widgetId);
    if (result.success && result.data) {
      await load();
    }
  }

  /// 记录组件收藏；后台静默失败，不影响本地收藏操作。
  Future<void> recordWidgetCollection(int widgetId) async {
    final ApiRet<bool> result =
        await _repository.recordWidgetCollection(widgetId);
    if (result.success && result.data) {
      await load();
    }
  }

  /// 退出登录时清除上一位用户的进度。
  void clear() {
    emit(const ProgressionState());
  }
}
