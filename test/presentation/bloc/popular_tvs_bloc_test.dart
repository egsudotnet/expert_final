import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/popular_tvs/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tv_dummy_objects.dart';
import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTvs
])
void main() {
  late PopularTvsBloc providerBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    providerBloc = PopularTvsBloc(
      mockGetPopularTvs
    );
  });

  blocTest<PopularTvsBloc, PopularTvsState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetPopularTvs.execute())
          .thenAnswer((_) async => Right([testTv]));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvs()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularTvsLoading(),
      PopularTvsHasData([testTv]),
    ],
    verify: (bloc) {
       verify(mockGetPopularTvs.execute());
    },
  );
}
