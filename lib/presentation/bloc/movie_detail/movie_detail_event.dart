part of 'movie_detail_bloc.dart';
 
abstract class MovieDetailEvent extends Equatable {}
 
class OnMovieDetail extends MovieDetailEvent { 
  final int id;
 
  OnMovieDetail(this.id);  
  @override
  List<Object> get props => [];
}


class OnMovieRecomendation extends MovieDetailEvent { 
  final int id;
 
  OnMovieRecomendation(this.id);  
  @override
  List<Object> get props => [];
}


class OnMovieWatchlistStatus extends MovieDetailEvent {
  final int id;
 
  OnMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class OnMovieWatchlistRemove extends MovieDetailEvent {
  final MovieDetail movieDetail;
 
  OnMovieWatchlistRemove(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
} 


class OnMovieWatchlistSave extends MovieDetailEvent {
  final MovieDetail movieDetail;
 
  OnMovieWatchlistSave(this.movieDetail);
  
  @override
  List<Object> get props => [movieDetail];
}