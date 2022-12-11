part of 'watchlist_tv_bloc.dart';
 
abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();
 
  @override
  List<Object> get props => [];
}
 
class TvWatchlistEmpty extends TvWatchlistState {}
 
class TvWatchlistLoading extends TvWatchlistState {}
 
class TvWatchlistError extends TvWatchlistState {
  final String message;
 
  TvWatchlistError(this.message);
 
  @override
  List<Object> get props => [message];
}

class TvWatchlistMessage extends TvWatchlistState {
  final String message;
 
  TvWatchlistMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> result;
 
  TvWatchlistHasData(this.result);
 
  @override
  List<Object> get props => [result];
}


class TvWatchlistStatus extends TvWatchlistState {
  final bool result;
 
  TvWatchlistStatus(this.result);
 
  @override
  List<Object> get props => [result];
}