import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart'; 

@GenerateMocks([
  GetWatchlistTvs,
  GetWatchListTvStatus,
  RemoveWatchlistTv,
  SaveWatchlistTv
])
void main() {
  late TvWatchlistBloc providerBloc;
  late GetWatchlistTvs getWatchlistTv;
  late GetWatchListTvStatus getWatchlistTvStatus;
  late RemoveWatchlistTv removeWatchlistTv;
  late SaveWatchlistTv saveWatchlistTv;

  setUp(() {
    getWatchlistTv = MockGetWatchlistTvs();
    getWatchlistTvStatus = MockGetWatchListTvStatus();
    removeWatchlistTv = MockRemoveWatchlistTv();
    saveWatchlistTv = MockSaveWatchlistTv();
    providerBloc = TvWatchlistBloc(
      getWatchlistTv,
      getWatchlistTvStatus,
      removeWatchlistTv,
      saveWatchlistTv,
    );
  });

  final tId = 1;
  final tStatus = true;
  final tTvList = [testTv];
  final String tMessageSaved = "Added from Watchlist";
  final String tMessageRemoved = "Removed from Watchlist";

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should get data from the usecase',
    build: () {
      when(getWatchlistTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlist()),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistHasData(tTvList),
    ],
    verify: (bloc) {
      verify(getWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should get status when data is gotten',
    build: () {
      when(getWatchlistTvStatus.execute(tId))
          .thenAnswer((_) async => tStatus);
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlistStatus(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvWatchlistStatus(tStatus),
    ],
    verify: (bloc) {
      verify(getWatchlistTvStatus.execute(tId));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should get info when status is removed',
    build: () {
      when(removeWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right(tMessageRemoved));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlistRemove(testTvDetail)),
    expect: () => [
      TvWatchlistMessage(tMessageRemoved),
    ],
    verify: (bloc) {
      verify(removeWatchlistTv.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'Should get info when status is added',
    build: () {
      when(saveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right(tMessageSaved));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlistSave(testTvDetail)),
    expect: () => [
      TvWatchlistMessage(tMessageSaved),
    ],
    verify: (bloc) {
      verify(saveWatchlistTv.execute(testTvDetail));
    },
  );
}