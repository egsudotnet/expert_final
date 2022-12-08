part of 'tv_recomendation_bloc.dart';
 
abstract class TvRecomendationState extends Equatable {}
 
class TvRecomendationEmpty extends TvRecomendationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TvRecomendationLoading extends TvRecomendationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
} 
 
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

 