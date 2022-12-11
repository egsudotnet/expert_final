import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/tv_dummy_objects.dart';
import 'tv_now_playing_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvs 
])
void main() {
  late TvNowPlayingBloc providerBloc;
  late MockGetNowPlayingTvs mockGetTvNowPlaying;

  setUp(() {
    mockGetTvNowPlaying = MockGetNowPlayingTvs();
    providerBloc = TvNowPlayingBloc(
      mockGetTvNowPlaying
    );
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Right([testTv]));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvNowPlaying()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      TvNowPlayingLoading(),
      TvNowPlayingHasData([testTv]),
    ],
    verify: (bloc) {
       verify(mockGetTvNowPlaying.execute());
    },
  );
}
