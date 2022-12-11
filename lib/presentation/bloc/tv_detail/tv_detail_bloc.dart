 
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_state.dart';
part 'tv_detail_event.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(
    this._getTvDetail,
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
  }
}
