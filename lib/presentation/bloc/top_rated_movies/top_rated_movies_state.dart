part of 'top_rated_movies_bloc.dart';
 
abstract class TopRatedMovieState extends Equatable {}
 
class TopRatedMovieEmpty extends TopRatedMovieState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TopRatedMovieLoading extends TopRatedMovieState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TopRatedMovieError extends TopRatedMovieState {
  final String message;
 
  TopRatedMovieError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TopRatedMovieHasData extends TopRatedMovieState {
  final List<Movie> result;
 
  TopRatedMovieHasData(this.result);
 
  @override
  List<Object> get props => [result];
}