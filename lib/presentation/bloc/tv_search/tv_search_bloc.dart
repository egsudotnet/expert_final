 
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_state.dart';
part 'tv_search_event.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs _searchTv;

  TvSearchBloc(this._searchTv) : super(TvSearchEmpty()) {
    on<TvOnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(TvSearchLoading());
      final result = await _searchTv.execute(query);
      result.fold((failure) {
        emit(TvSearchError(failure.message));
      }, (success) {
        emit(TvSearchHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
