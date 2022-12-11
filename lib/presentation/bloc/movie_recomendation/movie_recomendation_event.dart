part of 'movie_recomendation_bloc.dart';
 
abstract class MovieRecomendationEvent extends Equatable {}
 
class OnMovieRecomendation extends MovieRecomendationEvent { 
  final int id;
 
  OnMovieRecomendation(this.id);  
  @override
  List<Object> get props => [];
}