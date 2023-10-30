
import 'package:flutter/material.dart';

import '../../notifier/download_data_scope.dart';
import '../../notifier/progress_value_notifier.dart';

class DetailProgressView extends StatelessWidget{
  const DetailProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    ProgressValueNotifier progress = DownloadDataScope.of(context);
    return Stack(
      alignment: Alignment.center,
      children:[
        SizedBox(
          width: 200,
          height: 50,
          child: LinearProgressIndicator(
            value: progress.value,
            backgroundColor: Colors.grey,
          ),
        ),
        Text(progress.valueStr,style: TextStyle(color: Colors.white),)
      ],
    );
  }
}
