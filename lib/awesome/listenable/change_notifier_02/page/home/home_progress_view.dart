
import 'package:flutter/material.dart';
import 'package:flutter_unit/awesome/listenable/change_notifier_02/notifier/download_data_scope.dart';

import '../../notifier/progress_value_notifier.dart';

class HomeProgressView extends StatelessWidget{
  const HomeProgressView({super.key});


  @override
  Widget build(BuildContext context) {
    ProgressValueNotifier progress = DownloadDataScope.of(context);
    return Stack(
      alignment: Alignment.center,
      children:[
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: progress.value,
            backgroundColor: Colors.grey,
          ),
        ),
        Text(progress.valueStr)
      ],
    );
  }



}
