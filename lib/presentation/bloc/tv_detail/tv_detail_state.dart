part of 'tv_detail_bloc.dart';
 
abstract class TvDetailState extends Equatable {}
 
class TvDetailEmpty extends TvDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TvDetailLoading extends TvDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class TvDetailError extends TvDetailState {
  final String message;
 
  TvDetailError(this.message);
 
  @override
  List<Object> get props => [message];
}

class TvDetailMessage extends TvDetailState {
  final String message;
 
  TvDetailMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class TvDetailHasData extends TvDetailState {
  final TvDetail result;
 
  TvDetailHasData(this.result);
 
  @override
  List<Object> get props => [result];
}


class TvDetailStatus extends TvDetailState {
  final bool result;
 
  TvDetailStatus(this.result);
 
  @override
  List<Object> get props => [result];
}