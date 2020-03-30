

import 'search_event.dart';
import 'search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  @override
  SearchState get initialState => SearchStateNoSearch();//初始状态


  @override
  Stream<SearchState> transformEvents(
      Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next,) {
    return super.transformEvents(events
        .debounceTime(Duration(milliseconds: 500),),
      next,
    );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {

    if (event is EventTextChanged) {
      print(event.arg);
      if (event.arg.isEmpty) {
        yield SearchStateNoSearch();
      } else {
        yield SearchStateLoading();
        try {
//          final results = await GithubApi.search(event.arg);
//          if(results.items.isEmpty) yield SearchStateEmpty();
//          yield SearchStateSuccess(results);
        } catch (error) {
          yield  SearchStateError();
        }
      }
    }
  }
}