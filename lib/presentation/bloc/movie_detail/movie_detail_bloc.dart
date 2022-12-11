import 'package:ditonton/common/enums.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListMovieStatus _getWatchlistMovieStatus;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  MovieDetailBloc(
      this._getMovieDetail,
      this._getMovieRecommendations,
      this._getWatchlistMovieStatus,
      this._saveWatchlistMovie,
      this._removeWatchlistMovie)
      : super(MovieDetailState.loadFirst()) {
    on<OnMovieDetail>((event, emit) async {
      emit(state.copyWith(movieDetailState: BlocStateStatus.Loading));
      final result = await _getMovieDetail.execute(event.id);
      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (success) {
        emit(MovieDetailHasData(success));
      });
    });

    on<OnMovieRecomendation>((event, emit) async {
      emit(MovieRecomendationLoading());
      final result = await _getMovieRecommendations.execute(event.id);
      result.fold((failure) {
        emit(MovieRecomendationError(failure.message));
      }, (success) {
        emit(MovieRecomendationHasData(success));
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
