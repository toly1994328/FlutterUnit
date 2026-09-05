import 'dart:math';
import 'package:unit_env/unit_env.dart';
import '../model/workshop_item.dart';

/// 匠心工坊客户端接口。
class WorkshopRepository {
  WorkshopRepository({RequestHost<HostEnv>? host})
      : _host = host ?? FxDio()<FlutterUnitHost>();
  final RequestHost<HostEnv> _host;

  Future<ApiRet<List<WorkshopProduct>>> products([String? kind]) =>
      _host.get<List<WorkshopProduct>>(
          '/api/v1/workshop/products${kind == null ? '' : '?kind=$kind'}',
          convertor: _parseProducts);
  Future<ApiRet<List<WorkshopPurchase>>> purchases() =>
      _host.get<List<WorkshopPurchase>>(
          '/api/v1/workshop/purchases?page=1&page_size=50',
          convertor: _parsePurchases);
  Future<ApiRet<WorkshopPurchaseResult>> purchase(String productCode) =>
      _host.post<WorkshopPurchaseResult>(
        '/api/v1/workshop/purchases',
        data: <String, dynamic>{
          'product_code': productCode,
          'order_no': _orderNo(),
        },
        convertor: WorkshopPurchaseResult.fromApi,
      );

  List<WorkshopProduct> _parseProducts(dynamic data) =>
      List<dynamic>.from(data as List)
          .map<WorkshopProduct>(WorkshopProduct.fromApi)
          .toList();
  List<WorkshopPurchase> _parsePurchases(dynamic data) =>
      List<dynamic>.from(data as List)
          .map<WorkshopPurchase>(WorkshopPurchase.fromApi)
          .toList();

  String _orderNo() {
    final Random random = Random.secure();
    String hex(int count) => List<String>.generate(
        count, (_) => random.nextInt(16).toRadixString(16)).join();
    return '${hex(8)}-${hex(4)}-4${hex(3)}-${(8 + random.nextInt(4)).toRadixString(16)}${hex(3)}-${hex(12)}';
  }
}
