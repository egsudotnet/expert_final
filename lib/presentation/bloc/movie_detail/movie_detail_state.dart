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