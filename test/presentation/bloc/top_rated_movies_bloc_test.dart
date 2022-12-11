import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/movie_dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies
])
void main() {
  late PopularMoviesBloc providerBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    providerBloc = PopularMoviesBloc(
      mockGetPopularMovies
    );
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right([testMovie]));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovies()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData([testMovie]),
    ],
    verify: (bloc) {
       verify(mockGetPopularMovies.execute());
    },
  );
}
