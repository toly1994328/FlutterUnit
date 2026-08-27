/// FlutterUnit 服务端的应用运行接口。
enum UnitApi {
  hello('/hello'),
  appInfo('/appInfo/name/'),
  appVersion('/app_version');

  /// 接口相对路径。
  final String path;

  const UnitApi(this.path);
}
