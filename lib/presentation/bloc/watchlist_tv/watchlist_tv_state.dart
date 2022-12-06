part of 'watchlist_tv_bloc.dart';
 
abstract class TvWatchlistState extends Equatable {}
 
class TvWatchlistEmpty extends TvWatchlistState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TvWatchlistLoading extends TvWatchlistState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TvWatchlistError extends TvWatchlistState {
  final String message;
 
  TvWatchlistError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> result;
 
  TvWatchlistHasData(this.result);
 
  @override
  List<Object> get props => [result];
}