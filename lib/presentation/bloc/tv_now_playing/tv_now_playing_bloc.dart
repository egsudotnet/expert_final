import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_now_playing_state.dart';
part 'tv_now_playing_event.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTvs _getNowPlayingTv;

  TvNowPlayingBloc(this._getNowPlayingTv) : super(TvNowPlayingEmpty()) {
    on<OnTvNowPlaying>((event, emit) async {

      emit(TvNowPlayingLoading());
      final result = await _getNowPlayingTv.execute();
      result.fold((failure) {
        emit(TvNowPlayingError(failure.message));
      }, (success) {
        emit(TvNowPlayingHasData(success));
      });
    });
  }
}
