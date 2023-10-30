import 'dart:async';

import 'package:flutter/material.dart';
import '../../notifier/download_data_scope.dart';
import '../../notifier/progress_value_notifier.dart';
import '../detail/download_detail.dart';
import 'home_progress_view.dart';

class ChangeNotifierHome02 extends StatefulWidget {
  const ChangeNotifierHome02({super.key});

  @override
  State<ChangeNotifierHome02> createState() => _ChangeNotifierHome02State();
}

class _ChangeNotifierHome02State extends State<ChangeNotifierHome02> {

  TextEditingController c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("=========_ChangeNotifierHome02State#build===========");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _startTimer,
        child: const Icon(Icons.restart_alt),
      ),
      appBar: AppBar(
        title: const Text('下载进度通知模拟'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const DownloadDetailPage()));
          }, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: const Center(child: HomeProgressView()),
    );
  }

  Timer? _timer;

  ProgressValueNotifier get progress => DownloadDataScope.read(context);

  void _startTimer(){
    if(_timer!=null) return;
    if(progress.value==1.0){
      progress.value=0;
    }
    _timer = Timer.periodic(const Duration(milliseconds: 200),_updateProgress);
  }


  void _updateProgress(Timer timer) {
    if(progress.value>=1.0){
      timer.cancel();
      _timer = null;
      return;
    }
    progress.value += 0.01;
  }
}

