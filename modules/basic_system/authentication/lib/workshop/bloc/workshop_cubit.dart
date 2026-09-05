import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_env/unit_env.dart';
import '../model/workshop_item.dart';
import '../repository/workshop_repository.dart';

class WorkshopState {
  const WorkshopState(
      {this.products = const [],
      this.purchases = const [],
      this.kind,
      this.loading = false,
      this.buyingCode,
      this.error});
  final List<WorkshopProduct> products;
  final List<WorkshopPurchase> purchases;
  final String? kind;
  final bool loading;
  final String? buyingCode;
  final String? error;
}

/// 维护工坊商品、筛选和购买状态。
class WorkshopCubit extends Cubit<WorkshopState> {
  WorkshopCubit(this._repository) : super(const WorkshopState());
  final WorkshopRepository _repository;

  Future<void> load([String? kind]) async {
    final String selectedKind = kind ?? 'avatar_frame';
    final String? requestKind = selectedKind == 'owned' ? null : selectedKind;
    final bool switchingKind = state.kind != selectedKind;
    emit(WorkshopState(
        products: switchingKind ? const [] : state.products,
        purchases: state.purchases,
        kind: selectedKind,
        loading: true));
    final ApiRet<List<WorkshopProduct>> result =
        await _repository.products(requestKind);
    emit(result.success
        ? WorkshopState(
            products: _visibleProducts(result.data, selectedKind),
            purchases: state.purchases,
            kind: selectedKind)
        : WorkshopState(
            products: state.products,
            purchases: state.purchases,
            kind: selectedKind,
            error: result.msg));
  }

  /// 兑换商品；成功返回 null，失败返回可直接展示的原因。
  Future<String?> purchase(WorkshopProduct product) async {
    if (state.buyingCode != null) return '正在兑换其他商品';
    emit(WorkshopState(
        products: state.products,
        purchases: state.purchases,
        kind: state.kind,
        buyingCode: product.code));
    final ApiRet<WorkshopPurchaseResult> result =
        await _repository.purchase(product.code);
    if (!result.success) {
      final String message = _purchaseError(result.msg);
      emit(WorkshopState(
          products: state.products,
          purchases: state.purchases,
          kind: state.kind,
          error: message));
      return message;
    }
    final WorkshopPurchaseResult purchaseResult = result.data;
    if (purchaseResult.purchase.productCode != product.code) {
      const String message = '兑换结果与当前商品不一致，请刷新后重试';
      emit(WorkshopState(
          products: state.products,
          purchases: state.purchases,
          kind: state.kind,
          error: message));
      return message;
    }
    final List<WorkshopProduct> products =
        _markOwned(state.products, product.code, state.kind);
    emit(WorkshopState(
        products: products, purchases: state.purchases, kind: state.kind));
    await load('owned');
    return null;
  }

  String _purchaseError(String message) {
    if (message.contains('匠尘余额不足')) return '匠尘余额不足';
    if (message.contains('已拥有')) return '你已拥有该商品';
    return '兑换失败，请稍后重试';
  }

  /// 标记兑换成功的商品，并按当前 Tab 重新过滤列表。
  List<WorkshopProduct> _markOwned(
    List<WorkshopProduct> products,
    String productCode,
    String? selectedKind,
  ) {
    final List<WorkshopProduct> updated = [];
    for (final WorkshopProduct item in products) {
      final WorkshopProduct current =
          item.code == productCode ? item.asOwned() : item;
      updated.add(current);
    }
    return _visibleProducts(updated, selectedKind ?? 'avatar_frame');
  }

  /// 前两个 Tab 仅展示未拥有商品，“已拥有”展示全部已兑换商品。
  List<WorkshopProduct> _visibleProducts(
    List<WorkshopProduct> products,
    String selectedKind,
  ) {
    final Iterable<WorkshopProduct> visible = selectedKind == 'owned'
        ? products.where((WorkshopProduct item) => item.owned)
        : products.where(
            (WorkshopProduct item) =>
                !item.owned && item.honorKind == selectedKind,
          );
    return _sortProducts(visible.toList());
  }

  /// 可兑换商品按售价升序，已拥有商品按获得时间倒序排列。
  List<WorkshopProduct> _sortProducts(List<WorkshopProduct> products) {
    final List<WorkshopProduct> sorted = List<WorkshopProduct>.of(products);
    sorted.sort((WorkshopProduct left, WorkshopProduct right) {
      if (left.owned != right.owned) return left.owned ? 1 : -1;
      if (left.owned) {
        final DateTime leftTime =
            left.ownedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final DateTime rightTime =
            right.ownedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final int timeOrder = rightTime.compareTo(leftTime);
        if (timeOrder != 0) return timeOrder;
      }
      final int priceOrder = left.pricePoints.compareTo(right.pricePoints);
      return priceOrder != 0 ? priceOrder : left.code.compareTo(right.code);
    });
    return sorted;
  }

  Future<void> loadPurchases() async {
    final ApiRet<List<WorkshopPurchase>> result = await _repository.purchases();
    emit(result.success
        ? WorkshopState(
            products: state.products, purchases: result.data, kind: state.kind)
        : WorkshopState(
            products: state.products,
            purchases: state.purchases,
            kind: state.kind,
            error: result.msg));
  }
}
