import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_state.dart';
part 'watchlist_tv_event.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvs _getWatchlistTv;
  final GetWatchListTvStatus _getWatchlistTvStatus;
  final RemoveWatchlistTv _removeWatchlistTv;
  final SaveWatchlistTv _saveWatchlistTv;

  TvWatchlistBloc(
    this._getWatchlistTv,
    this._getWatchlistTvStatus,
    this._removeWatchlistTv,
    this._saveWatchlistTv
    ) : super(TvWatchlistEmpty()) {

    on<OnTvWatchlist>((event, emit) async { 
      emit(TvWatchlistLoading());
      final result = await _getWatchlistTv.execute();
      result.fold((failure) {
        emit(TvWatchlistError(failure.message));
      }, (success) {
        emit(TvWatchlistHasData(success));
      });
    });
 
    on<OnTvWatchlistStatus>((event, emit) async { 
      final result = await _getWatchlistTvStatus.execute(event.id);
      emit(TvWatchlistStatus(result));
    });

    on<OnTvWatchlistRemove>((event, emit) async { 
      final result = await _removeWatchlistTv.execute(event.tvDetail);
      result.fold((failure) {
        emit(TvWatchlistError(failure.message));
      }, (success) {
        emit(TvWatchlistMessage(success));
      });
    });
 
    on<OnTvWatchlistSave>((event, emit) async { 
      final result = await _saveWatchlistTv.execute(event.tvDetail);
      result.fold((failure) {
        emit(TvWatchlistError(failure.message));
      }, (success) {
        emit(TvWatchlistMessage(success));
      });
    });
  }
}
