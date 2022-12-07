import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_now_playing_state.dart';
part 'movie_now_playing_event.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovie;

  MovieNowPlayingBloc(this._getNowPlayingMovie) : super(MovieNowPlayingEmpty()) {
    on<OnMovieNowPlaying>((event, emit) async {

      emit(MovieNowPlayingLoading());
      final result = await _getNowPlayingMovie.execute();
      result.fold((failure) {
        emit(MovieNowPlayingError(failure.message));
      }, (success) {
        emit(MovieNowPlayingHasData(success));
      });
    });
  }
}
