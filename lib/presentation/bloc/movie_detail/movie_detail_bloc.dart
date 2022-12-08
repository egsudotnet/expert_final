 
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart'; 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist
    ) : super(MovieDetailEmpty()) {

    on<OnMovieDetail>((event, emit) async { 
      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(event.id);
      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (success) {
        emit(MovieDetailHasData(success));
      });
    });
 
    on<OnMovieDetailStatus>((event, emit) async { 
      final result = await _getWatchListStatus.execute(event.id);
      emit(MovieDetailStatus(result));
    });

    on<OnMovieDetailRemoveWatchlist>((event, emit) async { 
      final result = await _removeWatchlist.execute(event.movieDetail);
      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (success) {
        emit(MovieDetailMessage(success));
      });
    });
 
    on<OnMovieDetailSaveWatchlist>((event, emit) async { 
      final result = await _saveWatchlist.execute(event.movieDetail);
      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (success) {
        emit(MovieDetailMessage(success));
      });
    });
  }
}
