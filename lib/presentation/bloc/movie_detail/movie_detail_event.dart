part of 'movie_detail_bloc.dart';
 
abstract class MovieDetailEvent extends Equatable {}
 
class OnMovieDetail extends MovieDetailEvent { 
  final int id;
 
  OnMovieDetail(this.id);  
  @override
  List<Object> get props => [];
}

class OnMovieDetailStatus extends MovieDetailEvent {
  final int id;
 
  OnMovieDetailStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class Watchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
 
  Watchlist(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
} 


class OnMovieDetailSaveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
 
  OnMovieDetailSaveWatchlist(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
} 
 
class OnMovieDetailRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  OnMovieDetailRemoveWatchlist(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}