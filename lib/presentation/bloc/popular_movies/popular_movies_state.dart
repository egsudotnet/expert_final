part of 'popular_movies_bloc.dart';
 
abstract class PopularMoviesState extends Equatable {}
 
class PopularMoviesEmpty extends PopularMoviesState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class PopularMoviesLoading extends PopularMoviesState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class PopularMoviesError extends PopularMoviesState {
  final String message;
 
  PopularMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;
 
  PopularMoviesHasData(this.result);
 
  @override
  List<Object> get props => [result];
}