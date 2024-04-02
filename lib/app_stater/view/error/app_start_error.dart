import 'package:app/app.dart';
import 'package:flutter/material.dart';

class AppStartErrorPage extends StatelessWidget {
  final Object? error;
  const AppStartErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DragToMoveWrapper(
        child: AppBar(
          title: Text("App 启动异常"),
          actions: [WindowButtons()],
        ),
      ),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
