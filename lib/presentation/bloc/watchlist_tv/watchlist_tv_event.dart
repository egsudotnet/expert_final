part of 'watchlist_tv_bloc.dart';
 
abstract class TvWatchlistEvent extends Equatable {}
 
class OnTvWatchlist extends TvWatchlistEvent {   
  @override
  List<Object> get props => [];
}

class OnTvWatchlistStatus extends TvWatchlistEvent {
  final int id;
 
  OnTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class OnTvWatchlistRemove extends TvWatchlistEvent {
  final TvDetail tvDetail;
 
  OnTvWatchlistRemove(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
} 


class OnTvWatchlistSave extends TvWatchlistEvent {
  final TvDetail tvDetail;
 
  OnTvWatchlistSave(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
} 