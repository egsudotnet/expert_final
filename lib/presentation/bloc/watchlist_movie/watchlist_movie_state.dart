part of 'watchlist_movie_bloc.dart';
 
abstract class MovieWatchlistState extends Equatable {}
 
class MovieWatchlistEmpty extends MovieWatchlistState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieWatchlistLoading extends MovieWatchlistState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieWatchlistError extends MovieWatchlistState {
  final String message;
 
  MovieWatchlistError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;
 
  MovieWatchlistHasData(this.result);
 
  @override
  List<Object> get props => [result];
}