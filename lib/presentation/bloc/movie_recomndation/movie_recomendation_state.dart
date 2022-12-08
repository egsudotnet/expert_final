part of 'movie_recomendation_bloc.dart';
 
abstract class MovieRecomendationState extends Equatable {}
 
class MovieRecomendationEmpty extends MovieRecomendationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieRecomendationLoading extends MovieRecomendationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
} 
 
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

 