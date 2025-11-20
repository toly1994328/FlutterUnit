import 'dart:io';

void main() async {
  try {
    final interfaces = await NetworkInterface.list();
    
    for (final interface in interfaces) {
      for (final addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          print('设备IPv4地址: ${addr.address}');
          print('网络接口: ${interface.name}');
          return;
        }
      }
    }
    
    print('未找到IPv4地址');
  } catch (e) {
    print('获取IP地址失败: $e');
  }
}