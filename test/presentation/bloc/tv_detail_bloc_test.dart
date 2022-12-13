import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv
])
void main() {
  late TvDetailBloc providerBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    providerBloc = TvDetailBloc(
      mockGetTvDetail,
      mockGetTvRecommendations,
      mockGetWatchListTvStatus,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  final tId = 1;
  final tIsAdded = false;
  final tvStateInit = TvDetailState.loadFirst();
  
  blocTest<TvDetailBloc, TvDetailState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right([testTv]));
      when(mockGetWatchListTvStatus.execute(tId))
          .thenAnswer((_) async => tIsAdded);
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvDetail(tId)),
    expect: () => [
      tvStateInit.copyWith(
        tvDetailState: RequestState.Loading
      ),
      tvStateInit.copyWith(
            tvDetail: testTvDetail, 
            tvDetailState: RequestState.Loading,
            tvIsAdded: tIsAdded,
            tvMessage: ""
      ), 
      tvStateInit.copyWith(
              tvDetail: testTvDetail, 
              tvRecomendation: testTvList,
              tvDetailState: RequestState.Loaded,
              tvMessage:""
      ), 
    ],
    verify: (bloc) {
       verify(mockGetTvDetail.execute(tId));
    },
  );
}
