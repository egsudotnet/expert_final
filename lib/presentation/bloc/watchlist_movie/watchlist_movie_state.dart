part of 'watchlist_movie_bloc.dart';
 
abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
 
  @override
  List<Object> get props => [];
}
 
class MovieWatchlistEmpty extends MovieWatchlistState {}
 
class MovieWatchlistLoading extends MovieWatchlistState {}
 
class MovieWatchlistError extends MovieWatchlistState {
  final String message;
 
  MovieWatchlistError(this.message);
 
  @override
  List<Object> get props => [message];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String message;
 
  MovieWatchlistMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;
 
  MovieWatchlistHasData(this.result);
 
  @override
  List<Object> get props => [result];
}


class MovieWatchlistStatus extends MovieWatchlistState {
  final bool result;
 
  MovieWatchlistStatus(this.result);
 
  @override
  List<Object> get props => [result];
}