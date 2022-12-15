import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/movie_dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovie;

  setUp(() {
    mockSearchMovie = MockSearchMovies();
    searchBloc = MovieSearchBloc(mockSearchMovie);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, MovieSearchEmpty());
  });
 
final tMovieList = [testMovie];
final tQuery = 'spiderman';
 
blocTest<MovieSearchBloc, MovieSearchState>(
  'Should emit [Loading, HasData] when data is gotten successfully',
  build: () {
    when(mockSearchMovie.execute(tQuery))
        .thenAnswer((_) async => Right(tMovieList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(MovieOnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    MovieSearchLoading(),
    MovieSearchHasData(tMovieList),
  ],
  verify: (bloc) {
    verify(mockSearchMovie.execute(tQuery));
  },
);

blocTest<MovieSearchBloc, MovieSearchState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockSearchMovie.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    return searchBloc;
  },
  act: (bloc) => bloc.add(MovieOnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    MovieSearchLoading(),
    MovieSearchError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockSearchMovie.execute(tQuery));
  },
);

}
