import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/tv_dummy_objects.dart';

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tvStateInit = TvDetailState.loadFirst();

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester testWidget) async {
    when(() => mockTvDetailBloc.state).thenReturn(
        tvStateInit.copyWith(tvDetailState: RequestState.Loading));

    final toTest = find.byType(CircularProgressIndicator);

    await testWidget.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(toTest, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(tvStateInit.copyWith(
        tvDetail: testTvDetail,
        tvDetailState: RequestState.Loaded,
        tvIsAdded: true,
        tvMessage: ""));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay add icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(tvStateInit.copyWith(
        tvDetail: testTvDetail,
        tvDetailState: RequestState.Loaded,
        tvIsAdded: false,
        tvMessage: ""));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockTvDetailBloc,
      Stream.fromIterable([
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
        ),
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvMessageWatchlist: watchlistAddSuccessMessage,
        ),
      ]),
      initialState: TvDetailState.loadFirst(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    await tester.pump();

    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(watchlistAddSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockTvDetailBloc,
      Stream.fromIterable([
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
        ),
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvMessageWatchlist: watchlistRemoveSuccessMessage,
        ),
      ]),
      initialState: TvDetailState.loadFirst(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    await tester.pump();

    expect(watchlistButton, findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(watchlistRemoveSuccessMessage), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
      mockTvDetailBloc,
      Stream.fromIterable([
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
        ),
        TvDetailState.loadFirst().copyWith(
          tvDetailState: RequestState.Loaded,
          tvDetail: testTvDetail,
          tvMessageWatchlist: "Error",
        ),
      ]),
      initialState: TvDetailState.loadFirst(),
    );
 
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1))); 
    await tester.pump();
 
    expect(find.text('Error'), findsOneWidget);
  });
}
