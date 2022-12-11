import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListMovieStatus,
  RemoveWatchlistMovie,
  SaveWatchlistMovie
])
void main() {
  late MovieWatchlistBloc providerBloc;
  late GetWatchlistMovies getWatchlistMovie;
  late GetWatchListMovieStatus getWatchlistMovieStatus;
  late RemoveWatchlistMovie removeWatchlistMovie;
  late SaveWatchlistMovie saveWatchlistMovie;

  setUp(() {
    getWatchlistMovie = MockGetWatchlistMovies();
    getWatchlistMovieStatus = MockGetWatchListMovieStatus();
    removeWatchlistMovie = MockRemoveWatchlistMovie();
    saveWatchlistMovie = MockSaveWatchlistMovie();
    providerBloc = MovieWatchlistBloc(
      getWatchlistMovie,
      getWatchlistMovieStatus,
      removeWatchlistMovie,
      saveWatchlistMovie,
    );
  });

  final tId = 1;
  final tStatus = true;
  final tMovieList = [testMovie];
  final String tMessageSaved = "Added from Watchlist";
  final String tMessageRemoved = "Removed from Watchlist";

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'should get data from the usecase',
    build: () {
      when(getWatchlistMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlist()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(getWatchlistMovie.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should get status when data is gotten',
    build: () {
      when(getWatchlistMovieStatus.execute(tId))
          .thenAnswer((_) async => tStatus);
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlistStatus(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieWatchlistStatus(tStatus),
    ],
    verify: (bloc) {
      verify(getWatchlistMovieStatus.execute(tId));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should get info when status is removed',
    build: () {
      when(removeWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Right(tMessageRemoved));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlistRemove(testMovieDetail)),
    expect: () => [
      MovieWatchlistMessage(tMessageRemoved),
    ],
    verify: (bloc) {
      verify(removeWatchlistMovie.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should get info when status is added',
    build: () {
      when(saveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Right(tMessageSaved));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieWatchlistSave(testMovieDetail)),
    expect: () => [
      MovieWatchlistMessage(tMessageSaved),
    ],
    verify: (bloc) {
      verify(saveWatchlistMovie.execute(testMovieDetail));
    },
  );
}