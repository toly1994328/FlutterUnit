/// 匠心工坊中的可兑换商品。
class WorkshopProduct {
  const WorkshopProduct(
      {required this.code,
      required this.pricePoints,
      required this.owned,
      required this.ownedAt,
      required this.honorCode,
      required this.honorKind,
      required this.honorName,
      required this.honorDescription,
      required this.honorAssetUrl});
  final String code;
  final int pricePoints;
  final bool owned;
  final DateTime? ownedAt;
  final String honorCode;
  final String honorKind;
  final String honorName;
  final String honorDescription;
  final String honorAssetUrl;

  factory WorkshopProduct.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return WorkshopProduct(
        code: map['code'] as String? ?? '',
        pricePoints: map['price_points'] as int? ?? 0,
        owned: map['owned'] as bool? ?? false,
        ownedAt: DateTime.tryParse(map['owned_at'] as String? ?? ''),
        honorCode: map['honor_code'] as String? ?? '',
        honorKind: map['honor_kind'] as String? ?? '',
        honorName: map['honor_name'] as String? ?? '',
        honorDescription: map['honor_description'] as String? ?? '',
        honorAssetUrl: map['honor_asset_url'] as String? ?? '');
  }

  WorkshopProduct asOwned() => WorkshopProduct(
      code: code,
      pricePoints: pricePoints,
      owned: true,
      ownedAt: DateTime.now(),
      honorCode: honorCode,
      honorKind: honorKind,
      honorName: honorName,
      honorDescription: honorDescription,
      honorAssetUrl: honorAssetUrl);
}

/// 一条成功兑换记录。
class WorkshopPurchase {
  const WorkshopPurchase(
      {required this.orderNo,
      required this.productCode,
      required this.honorName,
      required this.honorAssetUrl,
      required this.pricePoints,
      required this.createdAt});
  final String orderNo;
  final String productCode;
  final String honorName;
  final String honorAssetUrl;
  final int pricePoints;
  final DateTime? createdAt;

  factory WorkshopPurchase.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return WorkshopPurchase(
        orderNo: map['order_no'] as String? ?? '',
        productCode: map['product_code'] as String? ?? '',
        honorName: map['honor_name'] as String? ?? '',
        honorAssetUrl: map['honor_asset_url'] as String? ?? '',
        pricePoints: map['price_points'] as int? ?? 0,
        createdAt: DateTime.tryParse(map['created_at'] as String? ?? ''));
  }
}

/// 商品兑换成功后由服务端返回的订单凭证与最新匠尘余额。
class WorkshopPurchaseResult {
  const WorkshopPurchaseResult({
    required this.purchase,
    required this.pointsBalance,
  });

  /// 本次真实落库的购买记录。
  final WorkshopPurchase purchase;

  /// 扣除商品价格后的匠尘余额。
  final int pointsBalance;

  /// 只接受完整的成功响应，避免把业务错误 JSON 当成购买成功。
  factory WorkshopPurchaseResult.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    final dynamic purchaseData = map['purchase'];
    final dynamic pointsBalance = map['points_balance'];
    if (purchaseData is! Map || pointsBalance is! int) {
      throw const FormatException('兑换未生成有效订单');
    }
    final WorkshopPurchase purchase = WorkshopPurchase.fromApi(purchaseData);
    if (purchase.orderNo.isEmpty || purchase.productCode.isEmpty) {
      throw const FormatException('兑换订单信息不完整');
    }
    return WorkshopPurchaseResult(
      purchase: purchase,
      pointsBalance: pointsBalance,
    );
  }
}
