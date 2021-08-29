// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:install_plugin/install_plugin.dart';
//
// void main() {
//   const MethodChannel channel = MethodChannel('install_plugin');
//   final List<MethodCall> log = <MethodCall>[];
//   String response;
//
//   channel.setMockMethodCallHandler((MethodCall methodCall) async {
//     log.add(methodCall);
//     return response;
//   });
//
//   tearDown(() {
//     log.clear();
//   });
//
//
//   test('installApk test', () async {
//     response = 'Success';
//     final fakePath = 'fake.apk';
//     final fakeAppId = 'com.example.install';
//     final String result = await InstallPlugin.installApk(fakePath, fakeAppId);
//     expect(
//       log,
//       <Matcher>[isMethodCall('installApk', arguments: {'filePath': fakePath, 'appId': fakeAppId})],
//     );
//     expect(result, response);
//   });
//
//   test('gotoAppStore test', () async {
//     response = null;
//     final fakeUrl = 'fake_url';
//     final String result = await InstallPlugin.gotoAppStore(fakeUrl);
//     expect(
//       log,
//       <Matcher>[
//         isMethodCall('gotoAppStore', arguments: {'urlString': fakeUrl})
//       ],
//     );
//     expect(result, isNull);
//   });
//
// }