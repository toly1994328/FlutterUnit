import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:tolyui/basic/basic.dart';

class AppStartErrorPage extends StatelessWidget {
  final Object? error;
  const AppStartErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredDragToMoveWrapper(
        child: AppBar(
          title: const Text(
            "App 启动异常",
            style: TextStyle(fontFamily: '宋体'),
          ),
          actions: const [WindowButtons()],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            Spacer(),
            TolyLink(
                href: 'https://github.com/toly1994328/',
                text: 'Github 开源地址: FlutterUnit',
                onTap: (l) {}),
            const Text("联系邮箱: 1981462002@qq.com"),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
