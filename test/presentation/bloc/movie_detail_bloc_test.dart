import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc providerBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    providerBloc = MovieDetailBloc(
      mockGetMovieDetail
    );
  });

  final tId = 1; 
  // MovieDetailBloc _arrangeUsecase() {
  //   // when(mockGetMovieDetail.execute(tId))
  //   //     .thenAnswer((_) async => Right(testMovieDetail));
  //   // when(mockGetMovieRecommendations.execute(tId))
  //   //     .thenAnswer((_) async => Right(tMovies));
  // }
 
  blocTest<MovieDetailBloc, MovieDetailState>(
    'should get data from the usecase', 
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetail(tId)),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
       verify(mockGetMovieDetail.execute(tId));
    },
  );

//   group('Get Movie Detail', () {
  blocTest<MovieDetailBloc, MovieDetailState>(
    'should change movie when data is gotten successfully', 
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return providerBloc;
    },
    act: (bloc) => bloc.add(OnMovieDetail(tId)),
    // wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
       verify(mockGetMovieDetail.execute(tId));
    },
  );

 
//     blocTest('should change movie when data is gotten successfully', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       expect(providerBloc.movieState, RequestState.Loaded);
//       expect(providerBloc.movie, testMovieDetail);
//       expect(listenerCallCount, 3);
//     });

//     blocTest('should change recommendation movies when data is gotten successfully',
//         () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       expect(providerBloc.movieState, RequestState.Loaded);
//       expect(providerBloc.movieRecommendations, tMovies);
//     });
//   });

//   group('Get Movie Recommendations', () {
//     blocTest('should get data from the usecase', () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       verify(mockGetMovieRecommendations.execute(tId));
//       expect(providerBloc.movieRecommendations, tMovies);
//     });

//     blocTest('should update recommendation state when data is gotten successfully',
//         () async {
//       // arrange
//       _arrangeUsecase();
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       expect(providerBloc.recommendationState, RequestState.Loaded);
//       expect(providerBloc.movieRecommendations, tMovies);
//     });

//     blocTest('should update error message when request in successful', () async {
//       // arrange
//       when(mockGetMovieDetail.execute(tId))
//           .thenAnswer((_) async => Right(testMovieDetail));
//       when(mockGetMovieRecommendations.execute(tId))
//           .thenAnswer((_) async => Left(ServerFailure('Failed')));
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       expect(providerBloc.recommendationState, RequestState.Error);
//       expect(providerBloc.message, 'Failed');
//     });
//   });

//   group('Watchlist', () {
//     blocTest('should get the watchlist status', () async {
//       // arrange
//       when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
//       // act
//       await providerBloc.loadWatchlistStatus(1);
//       // assert
//       expect(providerBloc.isAddedToWatchlist, true);
//     });

//     blocTest('should execute save watchlist when function called', () async {
//       // arrange
//       when(mockSaveWatchlist.execute(testMovieDetail))
//           .thenAnswer((_) async => Right('Success'));
//       when(mockGetWatchlistStatus.execute(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await providerBloc.addWatchlist(testMovieDetail);
//       // assert
//       verify(mockSaveWatchlist.execute(testMovieDetail));
//     });

//     blocTest('should execute remove watchlist when function called', () async {
//       // arrange
//       when(mockRemoveWatchlist.execute(testMovieDetail))
//           .thenAnswer((_) async => Right('Removed'));
//       when(mockGetWatchlistStatus.execute(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await providerBloc.removeFromWatchlist(testMovieDetail);
//       // assert
//       verify(mockRemoveWatchlist.execute(testMovieDetail));
//     });

//     blocTest('should update watchlist status when add watchlist success', () async {
//       // arrange
//       when(mockSaveWatchlist.execute(testMovieDetail))
//           .thenAnswer((_) async => Right('Added to Watchlist'));
//       when(mockGetWatchlistStatus.execute(testMovieDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await providerBloc.addWatchlist(testMovieDetail);
//       // assert
//       verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
//       expect(providerBloc.isAddedToWatchlist, true);
//       expect(providerBloc.watchlistMessage, 'Added to Watchlist');
//       expect(listenerCallCount, 1);
//     });

//     blocTest('should update watchlist message when add watchlist failed', () async {
//       // arrange
//       when(mockSaveWatchlist.execute(testMovieDetail))
//           .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
//       when(mockGetWatchlistStatus.execute(testMovieDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await providerBloc.addWatchlist(testMovieDetail);
//       // assert
//       expect(providerBloc.watchlistMessage, 'Failed');
//       expect(listenerCallCount, 1);
//     });
//   });

//   group('on Error', () {
//     blocTest('should return error when data is unsuccessful', () async {
//       // arrange
//       when(mockGetMovieDetail.execute(tId))
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       when(mockGetMovieRecommendations.execute(tId))
//           .thenAnswer((_) async => Right(tMovies));
//       // act
//       await providerBloc.fetchMovieDetail(tId);
//       // assert
//       expect(providerBloc.movieState, RequestState.Error);
//       expect(providerBloc.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
}
