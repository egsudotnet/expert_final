part of 'movie_recomendation_bloc.dart';
 
abstract class MovieRecomendationEvent extends Equatable {}
 
class OnMovieRecomendation extends MovieRecomendationEvent { 
  final int id;
 
  OnMovieRecomendation(this.id);  
  @override
  List<Object> get props => [];
}

class OnMovieRecomendationStatus extends MovieRecomendationEvent {
  final int id;
 
  OnMovieRecomendationStatus(this.id);

  @override
  List<Object> get props => [id];
} 

 
  
class OnMovieRecomendationGetRecomendation extends MovieRecomendationEvent {
  final int id;

  OnMovieRecomendationGetRecomendation(this.id);
  @override
  List<Object> get props => [id];
} 