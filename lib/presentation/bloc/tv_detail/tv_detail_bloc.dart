 
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart'; 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  // final GetWatchListStatus _getWatchListStatus;
  // final SaveWatchlist _saveWatchlist;
  // final RemoveWatchlist _removeWatchlist;

  TvDetailBloc(
    this._getTvDetail,
    // this._getWatchListStatus,
    // this._saveWatchlist,
    // this._removeWatchlist
    ) : super(TvDetailEmpty()) {

    on<OnTvDetail>((event, emit) async { 
      emit(TvDetailLoading());
      final result = await _getTvDetail.execute(event.id);
      result.fold((failure) {
        emit(TvDetailError(failure.message));
      }, (success) {
        emit(TvDetailHasData(success));
      });
    });
 
    // on<OnTvDetailStatus>((event, emit) async { 
    //   final result = await _getWatchListStatus.execute(event.id);
    //   emit(TvDetailStatus(result));
    // });

    // on<OnTvDetailRemoveWatchlist>((event, emit) async { 
    //   final result = await _removeWatchlist.execute(event.tvDetail);
    //   result.fold((failure) {
    //     emit(TvDetailError(failure.message));
    //   }, (success) {
    //     emit(TvDetailMessage(success));
    //   });
    // });
 
    // on<OnTvDetailSaveWatchlist>((event, emit) async { 
    //   final result = await _saveWatchlist.execute(event.tvDetail);
    //   result.fold((failure) {
    //     emit(TvDetailError(failure.message));
    //   }, (success) {
    //     emit(TvDetailMessage(success));
    //   });
    // });
  }
}
