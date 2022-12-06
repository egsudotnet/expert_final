 
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_state.dart';
part 'watchlist_tv_event.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvs _getWatchlistTv;

  TvWatchlistBloc(this._getWatchlistTv) : super(TvWatchlistEmpty()) {
    on<OnTvWatchlist>((event, emit) async {

      emit(TvWatchlistLoading());
      final result = await _getWatchlistTv.execute();
      result.fold((failure) {
        emit(TvWatchlistError(failure.message));
      }, (success) {
        emit(TvWatchlistHasData(success));
      });
    });
  }
}
