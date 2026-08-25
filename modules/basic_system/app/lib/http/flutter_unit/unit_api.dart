/// FlutterUnit 服务端的知识与版本接口。
enum UnitApi {
  hello('/hello'),
  repository('/repository/name/FlutterUnit'),
  point('/point'),
  pointComment('/pointComment/'),
  appInfo('/appInfo/name/'),
  appVersion('/app_version');

  /// 接口相对路径。
  final String path;

  const UnitApi(this.path);
}
