 
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recomendation_state.dart';
part 'movie_recomendation_event.dart';

class MovieRecomendationBloc extends Bloc<MovieRecomendationEvent, MovieRecomendationState> { 
  final GetMovieRecommendations _getMovieRecommendations; 

  MovieRecomendationBloc( 
    this._getMovieRecommendations, 
    ) : super(MovieRecomendationEmpty()) {

    on<OnMovieRecomendation>((event, emit) async { 
      emit(MovieRecomendationLoading());
      final result = await _getMovieRecommendations.execute(event.id);
      result.fold((failure) {
        emit(MovieRecomendationError(failure.message));
      }, (success) {
        emit(MovieRecomendationHasData(success));
      });
    });
  }
}
