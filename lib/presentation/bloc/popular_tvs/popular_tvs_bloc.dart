import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tvs_state.dart';
part 'popular_tvs_event.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs _getPopularTvsTv;

  PopularTvsBloc(this._getPopularTvsTv) : super(PopularTvsEmpty()) {
    on<OnPopularTvs>((event, emit) async {

      emit(PopularTvsLoading());
      final result = await _getPopularTvsTv.execute();
      result.fold((failure) {
        emit(PopularTvsError(failure.message));
      }, (success) {
        emit(PopularTvsHasData(success));
      });
    });
  }
}
