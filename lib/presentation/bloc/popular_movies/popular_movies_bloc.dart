 
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_state.dart';
part 'popular_movies_event.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMoviesTv;

  PopularMoviesBloc(this._getPopularMoviesTv) : super(PopularMoviesEmpty()) {
    on<OnPopularMovies>((event, emit) async {

      emit(PopularMoviesLoading());
      final result = await _getPopularMoviesTv.execute();
      result.fold((failure) {
        emit(PopularMoviesError(failure.message));
      }, (success) {
        emit(PopularMoviesHasData(success));
      });
    });
  }
}
