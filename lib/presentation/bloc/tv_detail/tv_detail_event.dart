part of 'tv_detail_bloc.dart';
 
abstract class TvDetailEvent extends Equatable {}
 
class OnTvDetail extends TvDetailEvent { 
  final int id;
 
  OnTvDetail(this.id);  
  @override
  List<Object> get props => [];
}


class OnTvRecomendation extends TvDetailEvent { 
  final int id;
 
  OnTvRecomendation(this.id);  
  @override
  List<Object> get props => [];
}


class OnTvWatchlistStatus extends TvDetailEvent {
  final int id;
 
  OnTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
} 


class OnTvWatchlistRemove extends TvDetailEvent {
  final TvDetail tvDetail;
 
  OnTvWatchlistRemove(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
} 


class OnTvWatchlistSave extends TvDetailEvent {
  final TvDetail tvDetail;
 
  OnTvWatchlistSave(this.tvDetail);
  
  @override
  List<Object> get props => [tvDetail];
}