// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv.dart';
// import 'package:ditonton/presentation/pages/tv_detail_page.dart';
// import 'package:ditonton/presentation/provider/tv_detail_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import '../../dummy_data/tv_dummy_objects.dart';
// import 'tv_detail_page_test.mocks.dart';

// @GenerateMocks([TvDetailBloc])
// void main() {
//   late MockTvDetailBloc mockBloc;

//   setUp(() {
//     mockBloc = MockTvDetailBloc();
//   });

//   Widget _makeTestableWidget(Widget body) {
//     return ChangeBlocProvider<TvDetailBloc>.value(
//       value: mockBloc,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   testWidgets(
//       'Watchlist button should display add icon when tv not added to watchlist',
//       (WidgetTester tester) async {
//     when(mockBloc.tvState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tv).thenReturn(testTvDetail);
//     when(mockBloc.recommendationState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tvRecommendations).thenReturn(<Tv>[]);
//     when(mockBloc.isAddedToWatchlist).thenReturn(false);

//     final watchlistButtonIcon = find.byIcon(Icons.add);

//     await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should dispay check icon when tv is added to wathclist',
//       (WidgetTester tester) async {
//     when(mockBloc.tvState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tv).thenReturn(testTvDetail);
//     when(mockBloc.recommendationState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tvRecommendations).thenReturn(<Tv>[]);
//     when(mockBloc.isAddedToWatchlist).thenReturn(true);

//     final watchlistButtonIcon = find.byIcon(Icons.check);

//     await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

//     expect(watchlistButtonIcon, findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display Snackbar when added to watchlist',
//       (WidgetTester tester) async {
//     when(mockBloc.tvState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tv).thenReturn(testTvDetail);
//     when(mockBloc.recommendationState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tvRecommendations).thenReturn(<Tv>[]);
//     when(mockBloc.isAddedToWatchlist).thenReturn(false);
//     when(mockBloc.watchlistMessage).thenReturn('Added to Watchlist');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(SnackBar), findsOneWidget);
//     expect(find.text('Added to Watchlist'), findsOneWidget);
//   });

//   testWidgets(
//       'Watchlist button should display AlertDialog when add to watchlist failed',
//       (WidgetTester tester) async {
//     when(mockBloc.tvState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tv).thenReturn(testTvDetail);
//     when(mockBloc.recommendationState).thenReturn(RequestState.Loaded);
//     when(mockBloc.tvRecommendations).thenReturn(<Tv>[]);
//     when(mockBloc.isAddedToWatchlist).thenReturn(false);
//     when(mockBloc.watchlistMessage).thenReturn('Failed');

//     final watchlistButton = find.byType(ElevatedButton);

//     await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

//     expect(find.byIcon(Icons.add), findsOneWidget);

//     await tester.tap(watchlistButton);
//     await tester.pump();

//     expect(find.byType(AlertDialog), findsOneWidget);
//     expect(find.text('Failed'), findsOneWidget);
//   });
// }
