part of 'tv_recomendation_bloc.dart';
 
abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();
 
  @override
  List<Object> get props => [];
}
 
class TvRecomendationEmpty extends TvRecomendationState {}
 
class TvRecomendationLoading extends TvRecomendationState {} 
 
class TvRecomendationError extends TvRecomendationState {
  final String message;
 
  TvRecomendationError(this.message);
 
  @override
  List<Object> get props => [message];
}

class TvRecomendationMessage extends TvRecomendationState {
  final String message;
 
  TvRecomendationMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TvRecomendationHasData extends TvRecomendationState {
  final List<Tv> result;
 
  TvRecomendationHasData(this.result);
 
  @override
  List<Object> get props => [result];
}

 