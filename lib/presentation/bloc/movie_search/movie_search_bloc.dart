 
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_state.dart';
part 'movie_search_event.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovie;

  MovieSearchBloc(this._searchMovie) : super(MovieSearchEmpty()) {
    on<MovieOnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(MovieSearchLoading());
      final result = await _searchMovie.execute(query);
      result.fold((failure) {
        emit(MovieSearchError(failure.message));
      }, (success) {
        emit(MovieSearchHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
