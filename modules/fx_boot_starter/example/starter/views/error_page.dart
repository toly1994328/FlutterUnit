import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/app_state.dart';

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 20,
          children: [
            Text("初始化异常:\n$error",textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppFixErrorBuilder<AppState>(
                shouldFix: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () {
                      context.fixStartError<AppState>();
                    },
                    child: const Text("修复异常"),
                  );
                },
                loading: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: null,
                    child: CupertinoActivityIndicator(),
                  );
                },
                error: (BuildContext context) {
                  return Text('当前应用无法修复\n请联系开发者处理。xxxxxx');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
