import 'dart:io';
import 'package:path/path.dart' as p;

void main() async {
  // 获取当前IP
  String? currentIP;
  try {
    final interfaces = await NetworkInterface.list();
    for (final interface in interfaces) {
      for (final addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          currentIP = addr.address;
          break;
        }
      }
      if (currentIP != null) break;
    }
  } catch (e) {
    print('获取IP失败: $e');
    return;
  }

  if (currentIP == null) {
    print('未找到IPv4地址');
    return;
  }

  // 查找并替换文件中的dev IP
  final hostFile = File(
      r'D:\Projects\Flutter\toly1994\FlutterUnit\modules\basic_system\unit_env\lib\src\host.dart');

  if (!await hostFile.exists()) {
    print('未找到host文件');
    return;
  }

  try {
    String content = await hostFile.readAsString();

    // 使用正则表达式替换dev IP
    final regex = RegExp(r"(HostEnv\.dev:\s*')([^']+)(')");
    final newContent = content.replaceAllMapped(regex, (match) => '${match.group(1)}$currentIP${match.group(3)}');

    if (content != newContent) {
      await hostFile.writeAsString(newContent);
      print('✅ 已将dev IP更新为: $currentIP');
    } else {
      print('⚠️ 未找到需要替换的dev IP配置');
    }
  } catch (e) {
    print('替换失败: $e');
  }
}
