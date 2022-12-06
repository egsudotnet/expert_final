import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTvs mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTvs();
    searchBloc = TvSearchBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, TvSearchEmpty());
  });

  final tTvModel = Tv(
    backdropPath: "/99vBORZixICa32Pwdwj0lWcr8K.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The DAmelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The DAmelio Show",
    overview:
        "From relative obscurity",
    popularity: 25.383,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9,
    voteCount: 3134
  );
final tTvList = <Tv>[tTvModel];
final tQuery = 'spiderman';
 
blocTest<TvSearchBloc, TvSearchState>(
  'Should emit [Loading, HasData] when data is gotten successfully',
  build: () {
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Right(tTvList));
    return searchBloc;
  },
  act: (bloc) => bloc.add(TvOnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    TvSearchLoading(),
    TvSearchHasData(tTvList),
  ],
  verify: (bloc) {
    verify(mockSearchTv.execute(tQuery));
  },
);

blocTest<TvSearchBloc, TvSearchState>(
  'Should emit [Loading, Error] when get search is unsuccessful',
  build: () {
    when(mockSearchTv.execute(tQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    return searchBloc;
  },
  act: (bloc) => bloc.add(TvOnQueryChanged(tQuery)),
  wait: const Duration(milliseconds: 500),
  expect: () => [
    TvSearchLoading(),
    TvSearchError('Server Failure'),
  ],
  verify: (bloc) {
    verify(mockSearchTv.execute(tQuery));
  },
);

}
