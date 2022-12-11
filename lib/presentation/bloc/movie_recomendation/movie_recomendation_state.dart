part of 'movie_recomendation_bloc.dart';
 
abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();
 
  @override
  List<Object> get props => [];
}
 
class MovieRecomendationEmpty extends MovieRecomendationState {}
 
class MovieRecomendationLoading extends MovieRecomendationState {} 
 
class MovieRecomendationError extends MovieRecomendationState {
  final String message;
 
  MovieRecomendationError(this.message);
 
  @override
  List<Object> get props => [message];
}

class MovieRecomendationMessage extends MovieRecomendationState {
  final String message;
 
  MovieRecomendationMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieRecomendationHasData extends MovieRecomendationState {
  final List<Movie> result;
 
  MovieRecomendationHasData(this.result);
 
  @override
  List<Object> get props => [result];
}

 