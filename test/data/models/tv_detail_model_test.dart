import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {  
  
  final tTvDetailModel = TvDetailModel(
    adult: false,
    backdropPath: "/99vBORZixICa32Pwdwj0lWcr8K.jpg",
    firstAirDate: "2021-09-03",
    genres: [
      GenreModel(
        id: 10764,
        name: "Reality"
      )
    ],
    homepage: "https://www.hulu.com/series/the-damelio-show-ad993806-7961-4eb3-9f92-e7b9a349ae22",
    id: 130392,
    inProduction: true,
    lastAirDate: "2022-10-26",
    name: "The DAmelio Show",
    numberOfEpisodes: 18,
    numberOfSeasons: 2,
    originalLanguage: "en",
    originalName: "The DAmelio Show",
    overview: "From relative obscurity and a seemingly normal life.",
    popularity: 22.652,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    status: "Returning Series",
    tagline: "Fame is one thing, family is everything.",
    type: "Reality",
    voteAverage: 9.002,
    voteCount: 3139
  );
 
  final tTvDetail = TvDetail(
    backdropPath: "/99vBORZixICa32Pwdwj0lWcr8K.jpg",
    firstAirDate: "2021-09-03",
    genres: [
      Genre(
        id: 10764,
        name: "Reality"
      )
    ],
    id: 130392,
    name: "The DAmelio Show",
    numberOfEpisodes: 18,
    numberOfSeasons: 2,
    originalLanguage: "en",
    originalName: "The DAmelio Show",
    overview: "From relative obscurity and a seemingly normal life.",
    popularity: 22.652,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9.002,
    voteCount: 3139
  );
 
      
  test('should be a subclass of Tv entity', () async {
    final result = tTvDetailModel.toEntity();
    expect(result, tTvDetail);
  });
 }
