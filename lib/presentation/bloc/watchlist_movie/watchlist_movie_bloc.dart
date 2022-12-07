 
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_state.dart';
part 'watchlist_movie_event.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies _getWatchlistMovie;
  final GetWatchListStatus _getWatchlistStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  MovieWatchlistBloc(
    this._getWatchlistMovie,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist
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
      final result = await _getWatchlistStatus.execute(event.id);
      emit(MovieWatchlistStatus(result));
    });

    on<OnMovieWatchlistRemove>((event, emit) async { 
      final result = await _removeWatchlist.execute(event.movieDetail);
      result.fold((failure) {
        emit(MovieWatchlistError(failure.message));
      }, (success) {
        emit(MovieWatchlistMessage(success));
      });
    });
    


  }
}
