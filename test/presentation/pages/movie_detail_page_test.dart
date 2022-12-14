import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/movie_dummy_objects.dart';

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final movieStateInit = MovieDetailState.loadFirst();

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester testWidget) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
        movieStateInit.copyWith(movieDetailState: RequestState.Loading));

    final toTest = find.byType(CircularProgressIndicator);

    await testWidget.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(toTest, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(movieStateInit.copyWith(
        movieDetail: testMovieDetail,
        movieDetailState: RequestState.Loaded,
        movieIsAdded: true,
        movieMessage: ""));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay add icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(movieStateInit.copyWith(
        movieDetail: testMovieDetail,
        movieDetailState: RequestState.Loaded,
        movieIsAdded: false,
        movieMessage: ""));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockMovieDetailBloc,
      Stream.fromIterable([
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieMessageWatchlist: watchlistAddSuccessMessage,
        ),
      ]),
      initialState: MovieDetailState.loadFirst(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
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
      mockMovieDetailBloc,
      Stream.fromIterable([
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieMessageWatchlist: watchlistRemoveSuccessMessage,
        ),
      ]),
      initialState: MovieDetailState.loadFirst(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
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
      mockMovieDetailBloc,
      Stream.fromIterable([
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.loadFirst().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieMessageWatchlist: "Error",
        ),
      ]),
      initialState: MovieDetailState.loadFirst(),
    );
 
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1))); 
    await tester.pump();
 
    expect(find.text('Error'), findsOneWidget);
  });
}
