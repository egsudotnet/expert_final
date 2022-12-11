part of 'tv_recomendation_bloc.dart';
 
abstract class TvRecomendationEvent extends Equatable {}
 
class OnTvRecomendation extends TvRecomendationEvent { 
  final int id;
 
  OnTvRecomendation(this.id);  
  @override
  List<Object> get props => [];
}

class OnTvRecomendationStatus extends TvRecomendationEvent {
  final int id;
 
  OnTvRecomendationStatus(this.id);

  @override
  List<Object> get props => [id];
}