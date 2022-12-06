 
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movies_state.dart';
part 'top_rated_movies_event.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovie;

  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieEmpty()) {
    on<OnTopRatedMovie>((event, emit) async {

      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovie.execute();
      result.fold((failure) {
        emit(TopRatedMovieError(failure.message));
      }, (success) {
        emit(TopRatedMovieHasData(success));
      });
    });
  }
}
