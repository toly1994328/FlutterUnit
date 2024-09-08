import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../algorithm/sort/functions.dart';
import 'sort_config.dart';

enum SortStatus{
  none, // 未操作
  sorting, // 排序中
  sorted, // 排序完成
}

class SortState with ChangeNotifier{

  SortState(){
    reset();
  }

  SortStatus status = SortStatus.none;
  List<int> data = [];
  SortConfig _config = SortConfig();
  SortConfig get config => _config;
  Random random = Random();

  set config(SortConfig config){
    _config = config;
    reset();
    notifyListeners();
  }

  void reset(){
    data.clear();
    status = SortStatus.none;
    notifyListeners();
    int count = config.count;
    if(config.seed!=-1){
      random = Random(config.seed);
    }
    for (int i = 0; i < count; i++) {
      data.add(random.nextInt(1000));
    }
  }

  void sort() async{
    status = SortStatus.sorting;
    notifyListeners();
    SortFunction? sortFunction = sortFunctionMap[config.name];
    if(sortFunction!=null){
      await sortFunction(data,(arr) async {
        await Future.delayed(config.duration);
        notifyListeners();
      });
    }
    status = SortStatus.sorted;
    notifyListeners();
  }
}

/// Provides the current [SortState] to descendant widgets in the tree.
class SortStateScope extends InheritedNotifier<SortState> {
  const SortStateScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static SortState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SortStateScope>()!.notifier!;
}