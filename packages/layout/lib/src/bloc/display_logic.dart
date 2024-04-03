import 'package:flutter/material.dart';

import 'display_state.dart';

class DisplayLogic with ChangeNotifier {
  DisplayLogic(this._state);

  DisplayState _state;

  DisplayState get state => _state;

  bool get enableNext => _state.activeIndex < _state.total-1;
  bool get enablePrev => _state.activeIndex > 0;

  void nextPage() {
    if(enableNext){
      _state = _state.copyWith(activeIndex: _state.activeIndex+1);
      notifyListeners();
    }
  }

  void prevPage() {
    if(enablePrev){
      _state = _state.copyWith(activeIndex: _state.activeIndex-1);
      notifyListeners();
    }
  }
}

class DisplayScope extends InheritedNotifier<DisplayLogic> {
  const DisplayScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static DisplayLogic of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DisplayScope>()!.notifier!;
}
