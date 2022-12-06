part of 'movie_search_bloc.dart';
 
abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
 
  @override
  List<Object> get props => [];
}
 
class MovieSearchEmpty extends MovieSearchState {}
 
class MovieSearchLoading extends MovieSearchState {}
 
class MovieSearchError extends MovieSearchState {
  final String message;
 
  MovieSearchError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieSearchHasData extends MovieSearchState {
  final List<Movie> result;
 
  MovieSearchHasData(this.result);
 
  @override
  List<Object> get props => [result];
}