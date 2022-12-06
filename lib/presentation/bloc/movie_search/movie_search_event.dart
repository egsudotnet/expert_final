part of 'movie_search_bloc.dart';
 
abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
 
  @override
  List<Object> get props => [];
}
 
class MovieOnQueryChanged extends MovieSearchEvent {
  final String query;
 
  MovieOnQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}
