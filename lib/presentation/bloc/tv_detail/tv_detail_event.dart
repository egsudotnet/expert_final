part of 'tv_detail_bloc.dart';
 
abstract class TvDetailEvent extends Equatable {}
 
class OnTvDetail extends TvDetailEvent { 
  final int id;
 
  OnTvDetail(this.id);  
  @override
  List<Object> get props => [];
}

class OnTvDetailStatus extends TvDetailEvent {
  final int id;
 
  OnTvDetailStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class Watchlist extends TvDetailEvent {
  final TvDetail tvDetail;
 
  Watchlist(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
} 


class OnTvDetailSaveWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;
 
  OnTvDetailSaveWatchlist(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
} 
 
class OnTvDetailRemoveWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;

  OnTvDetailRemoveWatchlist(this.tvDetail);
  @override
  List<Object> get props => [tvDetail];
}