import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tvs_state.dart';
part 'top_rated_tvs_event.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvs _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {

      emit(TopRatedTvLoading());
      final result = await _getTopRatedTv.execute();
      result.fold((failure) {
        emit(TopRatedTvError(failure.message));
      }, (success) {
        emit(TopRatedTvHasData(success));
      });
    });
  }
}
