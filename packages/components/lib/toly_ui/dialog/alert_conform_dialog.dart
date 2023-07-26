import 'dart:ui';

import 'package:flutter/material.dart';

class AlertConformDialog extends StatelessWidget {
  final String title;
  final String content;
  final String conformText;
  final String cancelText;
  final bool titleDivider;

  final Function()? onConform;
  final VoidCallback? onCancel;
  final Color? conformTextColor;

  const AlertConformDialog(
      {this.title = "title",
      this.content = "content",
      this.conformText = "确定",
      this.cancelText = "取消",
      this.onConform,
      this.titleDivider = false,
      this.onCancel,
      this.conformTextColor,
      Key? key})
      : super(key: key);

  final TextStyle noticeStyle =
      const TextStyle(color: Colors.grey, fontSize: 16);
  final TextStyle cancelTextStyle = const TextStyle(
      color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold);

  final TextStyle subTextStyle = const TextStyle(
      color: Color(0xff929292), fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: SizedBox(
        // height: 120,
        width: 320,
        // color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: titleDivider?10:15,bottom: titleDivider?10:0),
              child: Center(
                  child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
            ),
            if(titleDivider)
           const Divider(height: 1,),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Text(
                  content,
                  style: noticeStyle,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onCancel?.call();
                      Navigator.of(context).pop(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.grey.withAlpha(88),
                                  width: 1 / window.devicePixelRatio),
                              right: BorderSide(
                                  color: Colors.grey.withAlpha(88),
                                  width: 1 / window.devicePixelRatio))),
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        '取消',
                        style: cancelTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Navigator.of(context).pop();
                    onConform?.call();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.grey.withAlpha(88),
                                width: 1 / window.devicePixelRatio),
                            right: BorderSide(
                                color: Colors.grey.withAlpha(88),
                                width: 1 / window.devicePixelRatio))),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      conformText,
                      style: TextStyle(
                          color: conformTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
