import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListMovieStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie
])
void main() {
  late MovieDetailBloc providerBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListMovieStatus mockGetWatchListMovieStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListMovieStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    providerBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListMovieStatus,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  final tId = 1;
  final tIsAdded = false;
  final movieStateInit = MovieDetailState.loadFirst();
  
  blocTest<MovieDetailBloc, MovieDetailState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right([testMovie]));
      when(mockGetWatchListMovieStatus.execute(tId))
          .thenAnswer((_) async => tIsAdded);
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetail(tId)),
    expect: () => [
      movieStateInit.copyWith(
        movieDetailState: RequestState.Loading
      ),
      movieStateInit.copyWith(
            movieDetail: testMovieDetail, 
            movieDetailState: RequestState.Loading,
            movieIsAdded: tIsAdded,
            movieMessage: ""
      ), 
      movieStateInit.copyWith(
              movieDetail: testMovieDetail, 
              movieRecomendation: testMovieList,
              movieDetailState: RequestState.Loaded,
              movieMessage:""
      ), 
    ],
    verify: (bloc) {
       verify(mockGetMovieDetail.execute(tId));
    },
  );
}
