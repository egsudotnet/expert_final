import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  final GetTvRecommendations _getTvRecommendations;
  final GetWatchListTvStatus _getWatchlistTvStatus;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  TvDetailBloc(
      this._getTvDetail,
      this._getTvRecommendations,
      this._getWatchlistTvStatus,
      this._saveWatchlistTv,
      this._removeWatchlistTv)
      : super(TvDetailState.loadFirst()) {
    on<OnTvDetail>((event, emit) async {
      TvDetailState.loadFirst();
      emit(state.copyWith(
          tvDetailState: RequestState.Loading, tvMessageWatchlist: ""));
      final resultTvDetail = await _getTvDetail.execute(event.id);
      final resultTvRecommendation =
          await _getTvRecommendations.execute(event.id);
      final resultWatchlistTvStatus =
          await _getWatchlistTvStatus.execute(event.id);

      resultTvDetail.fold((failure) {
        emit(state.copyWith(tvDetailState: RequestState.Error));
      }, (success) {
        emit(state.copyWith(
            tvDetail: success,
            tvDetailState: RequestState.Loading,
            tvIsAdded: resultWatchlistTvStatus,
            tvMessage: ""));

        resultTvRecommendation.fold((failure) {
          emit(state.copyWith(
              tvDetailState: RequestState.Error, tvMessage: failure.message));
        }, (success) {
          emit(state.copyWith(
              tvRecomendation: success,
              tvDetailState: RequestState.Loaded,
              tvMessage: ""));
        });
      });
    });

    on<OnTvWatchlistStatus>((event, emit) async {
      final result = await _getWatchlistTvStatus.execute(event.id);
      emit(state.copyWith(tvIsAdded: result));
    });

    on<OnTvWatchlistRemove>((event, emit) async {
      final result = await _removeWatchlistTv.execute(event.tvDetail);
      result.fold((failure) {
        emit(state.copyWith(tvMessageWatchlist: failure.message));
      }, (success) {
        emit(state.copyWith(tvMessageWatchlist: success, tvIsAdded: false));
      });
    });

    on<OnTvWatchlistSave>((event, emit) async {
      final result = await _saveWatchlistTv.execute(event.tvDetail);
      result.fold((failure) {
        emit(state.copyWith(tvMessageWatchlist: failure.message));
      }, (success) {
        emit(state.copyWith(tvMessageWatchlist: success, tvIsAdded: true));
      });
    });
  }
}
