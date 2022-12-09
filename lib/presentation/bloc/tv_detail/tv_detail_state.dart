part of 'tv_detail_bloc.dart';
 
abstract class TvDetailState extends Equatable {
  const TvDetailState();
 
  @override
  List<Object> get props => [];}
 
class TvDetailEmpty extends TvDetailState {}
 
class TvDetailLoading extends TvDetailState {}
 
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


// class TvDetailStatus extends TvDetailState {
//   final bool result;
 
//   TvDetailStatus(this.result);
 
//   @override
//   List<Object> get props => [result];
// }