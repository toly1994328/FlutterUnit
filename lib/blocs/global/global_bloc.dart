import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 全局信息的bloc

class GlobalState extends Equatable {
  const GlobalState();

  @override
  List<Object> get props => [];
}

class GlobalColorState extends GlobalState {
  final Color color;

  const GlobalColorState(this.color);

  @override
  List<Object> get props => [color];
}

class AppBarHeightState extends GlobalState {
  final double height;

  const AppBarHeightState(this.height);

  @override
  List<Object> get props => [height];
}

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class EventSwitchColor extends GlobalEvent {
  final Color color;

  const EventSwitchColor(this.color);

  @override
  List<Object> get props => [color];
}

class UpdateAppBarHeight extends GlobalEvent {
  final double height;

  const UpdateAppBarHeight(this.height);

  @override
  List<Object> get props => [height];
}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  @override
  GlobalState get initialState => GlobalColorState(Colors.blue);

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is EventSwitchColor) {
      yield* _mapLoadWidgetToState(event.color);
    }
    if (event is UpdateAppBarHeight) {
      yield AppBarHeightState(event.height);
    }
  }

  Stream<GlobalState> _mapLoadWidgetToState(Color color) async* {
    yield GlobalColorState(color);
  }
}
