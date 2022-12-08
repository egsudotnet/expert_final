part of 'movie_detail_bloc.dart';
 
abstract class MovieDetailState extends Equatable {}
 
class MovieDetailEmpty extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieDetailLoading extends MovieDetailState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieDetailError extends MovieDetailState {
  final String message;
 
  MovieDetailError(this.message);
 
  @override
  List<Object> get props => [message];
}

class MovieDetailMessage extends MovieDetailState {
  final String message;
 
  MovieDetailMessage(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;
 
  MovieDetailHasData(this.result);
 
  @override
  List<Object> get props => [result];
}


class MovieDetailStatus extends MovieDetailState {
  final bool result;
 
  MovieDetailStatus(this.result);
 
  @override
  List<Object> get props => [result];
}
 
 
class MovieDetailHasRecomendation extends MovieDetailState {
  final List<Movie> result;
 
  MovieDetailHasRecomendation(this.result);
 
  @override
  List<Object> get props => [result];
}
