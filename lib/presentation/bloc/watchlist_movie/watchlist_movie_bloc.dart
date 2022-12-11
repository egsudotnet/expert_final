import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_state.dart';
part 'watchlist_movie_event.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovie;
  final GetWatchListMovieStatus _getWatchlistMovieStatus;
  final RemoveWatchlistMovie _removeWatchlistMovie;
  final SaveWatchlistMovie _saveWatchlistMovie;

  MovieWatchlistBloc(
    this._getWatchlistMovie,
    this._getWatchlistMovieStatus,
    this._removeWatchlistMovie,
    this._saveWatchlistMovie
    ) : super(MovieWatchlistEmpty()) {

    on<OnMovieWatchlist>((event, emit) async { 
      emit(MovieWatchlistLoading());
      final result = await _getWatchlistMovie.execute();
      result.fold((failure) {
        emit(MovieWatchlistError(failure.message));
      }, (success) {
        emit(MovieWatchlistHasData(success));
      });
    });
  
    on<OnMovieWatchlistStatus>((event, emit) async { 
      final result = await _getWatchlistMovieStatus.execute(event.id);
      emit(MovieWatchlistStatus(result));
    });

    on<OnMovieWatchlistRemove>((event, emit) async { 
      final result = await _removeWatchlistMovie.execute(event.movieDetail);
      result.fold((failure) {
        emit(MovieWatchlistError(failure.message));
      }, (success) {
        emit(MovieWatchlistMessage(success));
      });
    });
 
    on<OnMovieWatchlistSave>((event, emit) async { 
      final result = await _saveWatchlistMovie.execute(event.movieDetail);
      result.fold((failure) {
        emit(MovieWatchlistError(failure.message));
      }, (success) {
        emit(MovieWatchlistMessage(success));
      });
    });
  }
}
