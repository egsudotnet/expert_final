part of 'watchlist_movie_bloc.dart';
 
abstract class MovieWatchlistEvent extends Equatable {}
 
class OnMovieWatchlist extends MovieWatchlistEvent {   
  @override
  List<Object> get props => [];
}

class OnMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;
 
  OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class OnMovieWatchlistRemove extends MovieWatchlistEvent {
  final MovieDetail movieDetail;
 
  OnMovieWatchlistRemove(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
} 


class OnMovieWatchlistSave extends MovieWatchlistEvent {
  final MovieDetail movieDetail;
 
  OnMovieWatchlistSave(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
} 