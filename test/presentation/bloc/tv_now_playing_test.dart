import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/provider/tv_now_playing_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_now_playing_test.mocks.dart'; 
 

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late TvNowPlayingNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    notifier = TvNowPlayingNotifier(mockGetNowPlayingTvs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
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

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTvNowPlaying();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvs data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchTvNowPlaying();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvNowPlaying();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}

