 
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recomendation_state.dart';
part 'tv_recomendation_event.dart';

class TvRecomendationBloc extends Bloc<TvRecomendationEvent, TvRecomendationState> { 
  final GetTvRecommendations _getTvRecommendations; 

  TvRecomendationBloc( 
    this._getTvRecommendations, 
    ) : super(TvRecomendationEmpty()) {

    on<OnTvRecomendation>((event, emit) async { 
      emit(TvRecomendationLoading());
      final result = await _getTvRecommendations.execute(event.id);
      result.fold((failure) {
        emit(TvRecomendationError(failure.message));
      }, (success) {
        emit(TvRecomendationHasData(success));
      });
    });
  }
}
