part of 'top_rated_tvs_bloc.dart';
 
abstract class TopRatedTvState extends Equatable {}
 
class TopRatedTvEmpty extends TopRatedTvState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TopRatedTvLoading extends TopRatedTvState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TopRatedTvError extends TopRatedTvState {
  final String message;
 
  TopRatedTvError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> result;
 
  TopRatedTvHasData(this.result);
 
  @override
  List<Object> get props => [result];
}