part of 'movie_now_playing_bloc.dart';
 
abstract class MovieNowPlayingState extends Equatable {}
 
class MovieNowPlayingEmpty extends MovieNowPlayingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieNowPlayingLoading extends MovieNowPlayingState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
 
class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;
 
  MovieNowPlayingError(this.message);
 
  @override
  List<Object> get props => [message];
}
 
class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> result;
 
  MovieNowPlayingHasData(this.result);
 
  @override
  List<Object> get props => [result];
}