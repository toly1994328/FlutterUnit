import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter_unit/widget_system/repositories/repositories.dart';

import 'search_event.dart';
import 'search_state.dart';

const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final WidgetRepository repository;

  SearchBloc({required this.repository}) : super(SearchStateNoSearch()) {
    on<SearchWidgetEvent>(_onSearchChanged, transformer: debounce(_duration));
  }

  void _onSearchChanged(
      SearchWidgetEvent event, Emitter<SearchState> emit) async {
    if (event.args.name.isEmpty && event.args.stars.every((e) => e == -1)) {
      emit(SearchStateNoSearch());
    } else {
      emit(SearchStateLoading());
      try {
        final results = await repository.searchWidgets(event.args);
        results.isEmpty
            ? emit(SearchStateEmpty())
            : emit(SearchStateSuccess(results));
      } catch (error) {
        print(error);
        emit(SearchStateError());
      }
    }
  }
}