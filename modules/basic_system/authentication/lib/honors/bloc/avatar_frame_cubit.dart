import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_env/unit_env.dart';

import '../model/user_honor.dart';
import '../repository/honor_repository.dart';

/// 当前装备头像框的加载状态。
class AvatarFrameState {
  const AvatarFrameState({
    this.honors = const [],
    this.frame,
    this.loading = false,
    this.error,
  });

  /// 当前用户已经获得的全部奖励。
  final List<UserHonor> honors;

  /// 当前装备的头像框，为空表示未装备。
  final UserHonor? frame;

  /// 是否正在同步服务端状态。
  final bool loading;

  /// 最近一次同步失败信息。
  final String? error;
}

/// 维护当前登录用户的头像框状态。
class AvatarFrameCubit extends Cubit<AvatarFrameState> {
  AvatarFrameCubit(this._repository) : super(const AvatarFrameState());

  /// 用户荣誉数据仓库。
  final HonorRepository _repository;

  /// 登录后同步当前装备的头像框。
  Future<void> load() async {
    emit(AvatarFrameState(
      honors: state.honors,
      frame: state.frame,
      loading: true,
    ));
    final ApiRet<List<UserHonor>> result = await _repository.loadMyHonors();
    if (!result.success) {
      emit(AvatarFrameState(
        honors: state.honors,
        frame: state.frame,
        error: result.msg,
      ));
      return;
    }
    final UserHonor? frame = _findEquippedFrame(result.data);
    emit(AvatarFrameState(honors: result.data, frame: frame));
  }

  /// 装备指定头像框并更新全局头像展示。
  Future<bool> equip(String code) async {
    emit(AvatarFrameState(
      honors: state.honors,
      frame: state.frame,
      loading: true,
    ));
    final ApiRet<UserHonor?> result = await _repository.equipAvatarFrame(code);
    if (!result.success) {
      emit(AvatarFrameState(
        honors: state.honors,
        frame: state.frame,
        error: result.msg,
      ));
      return false;
    }
    final List<UserHonor> honors = _updateEquippedFrame(code);
    emit(AvatarFrameState(honors: honors, frame: result.data));
    return true;
  }

  /// 卸下头像框并更新全局头像展示。
  Future<bool> unequip() async {
    emit(AvatarFrameState(
      honors: state.honors,
      frame: state.frame,
      loading: true,
    ));
    final ApiRet<UserHonor?> result = await _repository.unequipAvatarFrame();
    if (!result.success) {
      emit(AvatarFrameState(
        honors: state.honors,
        frame: state.frame,
        error: result.msg,
      ));
      return false;
    }
    final List<UserHonor> honors = _updateEquippedFrame(null);
    emit(AvatarFrameState(honors: honors));
    return true;
  }

  /// 装配一枚徽章并同步最多三个徽章的全局展示。
  Future<bool> equipBadge(String code) async {
    emit(AvatarFrameState(
      honors: state.honors,
      frame: state.frame,
      loading: true,
    ));
    final ApiRet<List<UserHonor>> result = await _repository.equipBadge(code);
    return _finishBadgeChange(result);
  }

  /// 取消装配一枚徽章并同步全局展示。
  Future<bool> unequipBadge(String code) async {
    emit(AvatarFrameState(
      honors: state.honors,
      frame: state.frame,
      loading: true,
    ));
    final ApiRet<List<UserHonor>> result = await _repository.unequipBadge(code);
    return _finishBadgeChange(result);
  }

  /// 退出登录时清除上一位用户的头像框。
  void clear() {
    emit(const AvatarFrameState());
  }

  UserHonor? _findEquippedFrame(List<UserHonor> honors) {
    for (final UserHonor honor in honors) {
      if (honor.kind == 'avatar_frame' && honor.equipped) return honor;
    }
    return null;
  }

  List<UserHonor> _updateEquippedFrame(String? code) {
    return state.honors.map<UserHonor>((UserHonor honor) {
      if (honor.kind != 'avatar_frame') return honor;
      return honor.copyWith(equipped: honor.code == code);
    }).toList();
  }

  bool _finishBadgeChange(ApiRet<List<UserHonor>> result) {
    if (!result.success) {
      emit(AvatarFrameState(
        honors: state.honors,
        frame: state.frame,
        error: result.msg,
      ));
      return false;
    }
    final Set<String> equippedCodes =
        result.data.map<String>((UserHonor honor) => honor.code).toSet();
    final List<UserHonor> honors =
        state.honors.map<UserHonor>((UserHonor honor) {
      if (honor.kind != 'badge') return honor;
      return honor.copyWith(equipped: equippedCodes.contains(honor.code));
    }).toList();
    emit(AvatarFrameState(honors: honors, frame: state.frame));
    return true;
  }
}
