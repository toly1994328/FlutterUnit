

import 'package:flutter/material.dart';
import 'package:flutter_unit/repositories/rep/widget_repository.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_unit/app/utils/stream_ext/ext.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WidgetRepository repository;

  SearchBloc({@required this.repository}):super(SearchStateNoSearch());


  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, TransitionFunction<SearchEvent, SearchState> transitionFn) {
      return super.transformEvents(events
          .debounceTime(Duration(milliseconds: 500),),
        transitionFn,
      );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if (event is SearchWidgetEvent) {
      if (event.args.name.isEmpty&&event.args.stars.every((e)=>e==-1)) {
        yield SearchStateNoSearch();
      } else {
        yield SearchStateLoading();
        try {
          final results = await repository.searchWidgets(event.args);
           yield results.length==0?SearchStateEmpty():SearchStateSuccess(results);
        } catch (error) {
          print(error);
          yield  SearchStateError();
        }
      }
    }
  }
}