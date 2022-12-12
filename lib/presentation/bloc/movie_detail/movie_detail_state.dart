part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final bool movieIsAdded;
  final List<Movie> movieRecomendation;
  final String movieMessage;
  final RequestState movieDetailState;
  final String movieMessageWatchlist;

  const MovieDetailState(
      {
      required this.movieDetail,
      required this.movieIsAdded,
      required this.movieRecomendation,
      required this.movieMessage,
      required this.movieDetailState,
      required this.movieMessageWatchlist
      });

  factory MovieDetailState.loadFirst() {
    return const MovieDetailState(
      movieDetail: null,
      movieMessage: '',
      movieDetailState: RequestState.Empty,
      movieIsAdded: false,
      movieRecomendation: [],
      movieMessageWatchlist:""
    );
  }

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    bool? movieIsAdded,
    List<Movie>? movieRecomendation,
    String? movieMessage,
    RequestState? movieDetailState,
    String? movieMessageWatchlist  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieIsAdded: movieIsAdded ?? this.movieIsAdded,
      movieRecomendation: movieRecomendation ?? this.movieRecomendation,
      movieMessage: movieMessage ?? this.movieMessage,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieMessageWatchlist: movieMessageWatchlist ?? this.movieMessageWatchlist,
    );
  }

  @override
  List<Object?> get props => [
      movieDetail,
      movieMessage,
      movieDetailState,
      movieIsAdded,
      movieRecomendation,
      movieMessageWatchlist
  ];
}
 
// class MovieDetailEmpty extends MovieDetailState {}
 
// class MovieDetailLoading extends MovieDetailState {}
 
// class MovieDetailError extends MovieDetailState {
//   final String message;
 
//   MovieDetailError(this.message);
 
//   @override
//   List<Object> get props => [message];
// }

// class MovieDetailMessage extends MovieDetailState {
//   final String message;
 
//   MovieDetailMessage(this.message);
 
//   @override
//   List<Object> get props => [message];
// }
 
// class MovieDetailHasData extends MovieDetailState {
//   final MovieDetail result;
 
//   MovieDetailHasData(this.result);
 
//   @override
//   List<Object> get props => [result];
// }

// class MovieRecomendationLoading extends MovieDetailState {} 
 
// class MovieRecomendationError extends MovieDetailState {
//   final String message;
 
//   MovieRecomendationError(this.message);
 
//   @override
//   List<Object> get props => [message];
// }

// class MovieRecomendationHasData extends MovieDetailState {
//   final List<Movie> result;
 
//   MovieRecomendationHasData(this.result);
 
//   @override
//   List<Object> get props => [result];
// }

// class MovieWatchlistError extends MovieDetailState {
//   final String message;
 
//   MovieWatchlistError(this.message);
 
//   @override
//   List<Object> get props => [message];
// }

// class MovieWatchlistMessage extends MovieDetailState {
//   final String message;
 
//   MovieWatchlistMessage(this.message);
 
//   @override
//   List<Object> get props => [message];
// }

// class MovieWatchlistStatus extends MovieDetailState {
//   final bool result;
 
//   MovieWatchlistStatus(this.result);
 
//   @override
//   List<Object> get props => [result];
// }