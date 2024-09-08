

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef AsyncTask = Future<void> Function(BuildContext context);

/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:
class DeleteMessagePanel extends StatelessWidget {
  final String title;
  final String msg;
  final String? conformText;
  final String? cancelText;
  final AsyncTask task;
  final Widget? icon;

  const DeleteMessagePanel({
    Key? key,
    required this.title,
    required this.msg,
    required this.task,
     this.conformText,
    this.icon,
     this.cancelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent,
      elevation: 0,
      padding: EdgeInsets.zero,
      shape: const StadiumBorder(),
    );
    Color? cancelTextColor = isDark?Colors.white:Theme.of(context).textTheme.displayMedium?.color;
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon??  const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Text(
                      msg,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            // backgroundColor: Color(value),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            cancelText?? '取消',
                            style:
                                TextStyle(fontSize: 12, color: cancelTextColor,height: 1),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      AsyncButton(
                        conformText: conformText??'删除',
                        task: task,
                        style: style,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MobileMessagePanel extends StatelessWidget {
  final String title;
  final String msg;
  final String? conformText;
  final String? cancelText;
  final Widget? icon;
  final Color? conformColor;
  final AsyncTask task;

  const MobileMessagePanel({
    Key? key,
    required this.title,
    required this.msg,
    required this.task,
    this.conformText,
    this.conformColor,
    this.icon,
    this.cancelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: conformColor??Colors.redAccent,
      elevation: 0,
      padding: EdgeInsets.zero,
      minimumSize: Size(70, 35),
      shape: const StadiumBorder(),
    );
    Color? cancelTextColor =isDark?Colors.white: Theme.of(context).textTheme.displayMedium?.color;
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [     icon?? const Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
              ),
                const SizedBox(
                  width: 6,
                ), Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
              child: Text(
                msg,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      // backgroundColor: Color(value),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      minimumSize: Size(70, 35),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      cancelText?? '取消',
                      style:
                      TextStyle(fontSize: 12, color: cancelTextColor,height: 1),
                    )),
                const SizedBox(
                  width: 10,
                ),
                AsyncButton(
                  conformText: conformText??'删除',
                  task: task,
                  style: style,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AsyncButton extends StatefulWidget {
  final ButtonStyle? style;
  final AsyncTask task;
  final String conformText;

  const AsyncButton({
    super.key,
    required this.task,
    this.style,
    required this.conformText,
  });

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _loading ? null : _doTask,
        style: widget.style??ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const StadiumBorder()),
        child: _loading
            ? const CupertinoActivityIndicator(radius: 8)
            :Text(
          widget.conformText,
          style: const TextStyle(fontSize: 12,height: 1),
        ));
  }

  void _doTask() async {
    setState(() {
      _loading = true;
    });
    await widget.task(context);
    setState(() {
      _loading = false;
    });
  }
}
