import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recomendation/movie_recomendation_bloc.dart'; 
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart'; 
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
 

class MovieDetailEventFake extends Fake 
  implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake 
  implements MovieDetailState {}

class MockMovieDetailBloc 
  extends MockBloc<MovieDetailEvent, MovieDetailState> 
  implements MovieDetailBloc {}

class MovieWatchlistEventFake extends Fake 
  implements MovieWatchlistEvent {}

class MovieWatchlistStateFake extends Fake 
  implements MovieWatchlistState {}

class MockMovieWatchlistBloc 
  extends MockBloc<MovieWatchlistEvent, MovieWatchlistState> 
  implements MovieWatchlistBloc {}

class MovieRecomendationEventFake extends Fake 
  implements MovieRecomendationEvent {}

class MovieRecomendationStateFake extends Fake 
  implements MovieRecomendationState {}

class MockMovieRecomendationBloc 
  extends MockBloc<MovieRecomendationEvent, MovieRecomendationState> 
  implements MovieRecomendationBloc {}
  
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockMovieRecomendationBloc mockMovieRecomendationBloc;
 

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieRecomendationEventFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecomendationBloc = MockMovieRecomendationBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return BlocProvider<MovieDetailBloc>.value(
  //     value: mockMovieDetailBloc,
  //     child: BlocProvider<MockMovieRecomendationBloc>.value(
  //       value: mockMovieRecomendationBloc,
  //       child: BlocProvider<MockMovieWatchlistBloc>.value(
  //         value: mockMovieWatchlistBloc,
  //         child: MaterialApp(
  //           home: body,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
              create: (context) => mockMovieDetailBloc),
          BlocProvider<MockMovieRecomendationBloc>(
              create: (context) => mockMovieRecomendationBloc),
          BlocProvider<MockMovieWatchlistBloc>(
              create: (context) => mockMovieWatchlistBloc)
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  // testWidgets(
  //     'Detail Movie Page should display Progressbar when loading',
  //     (WidgetTester tester) async {
  //   when(() => mockMovieDetailBloc.state).thenReturn(
  //     MovieDetailState.MovieDetailLoading().copyWith(
  //       movieDetailState: RequestState.Loading,
  //     ),
  //   );

  //   final progressBarFinder = find.byType(CircularProgressIndicator);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(progressBarFinder, findsOneWidget);
  // });
  
  // Widget _makeTestableWidget(Widget body) {
  //   return BlocProvider<MovieDetailBloc>(
  //     create: (context) => mockMovieDetailBloc,
  //     child: BlocProvider<MockMovieRecomendationBloc>(
  //       create: (context) => mockMovieRecomendationBloc,
  //       child: BlocProvider<MockMovieWatchlistBloc>(
  //         create: (context) => mockMovieWatchlistBloc,
  //         child: MaterialApp(
  //           home: body,
  //         ),
  //       ),
  //     ),
  //   );
  // } 

  final movieState = MovieDetailState.loadFirst();

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });


  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester testWidget) async { 
    when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    // when(() => mockMovieRecomendationBloc.state).thenReturn(MovieRecomendationLoading());
    // when(() => mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistLoading());
  
    final toTest = find.byType(CircularProgressIndicator);

    await testWidget.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(toTest, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should dispay check icon when movie is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockMovieDetailBloc.movieState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movie).thenReturn(testMovieDetail);
  //   when(mockMovieDetailBloc.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockMovieDetailBloc.isAddedToWatchlist).thenReturn(true);

  //   final watchlistButtonIcon = find.byIcon(Icons.check);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockMovieDetailBloc.movieState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movie).thenReturn(testMovieDetail);
  //   when(mockMovieDetailBloc.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockMovieDetailBloc.isAddedToWatchlist).thenReturn(false);
  //   when(mockMovieDetailBloc.watchlistMessage).thenReturn('Added to Watchlist');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockMovieDetailBloc.movieState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movie).thenReturn(testMovieDetail);
  //   when(mockMovieDetailBloc.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockMovieDetailBloc.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockMovieDetailBloc.isAddedToWatchlist).thenReturn(false);
  //   when(mockMovieDetailBloc.watchlistMessage).thenReturn('Failed');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
 