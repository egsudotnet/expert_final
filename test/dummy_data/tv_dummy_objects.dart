import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
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
    voteCount: 3134);

final testTvList = [testTv];

    // genres: [Genre(id: 1, name: 'Action')], 
final testTvDetail = TvDetail(
    backdropPath: "/99vBORZixICa32Pwdwj0lWcr8K.jpg",
    firstAirDate: "2021-09-03", 
    genres: [Genre(id: 1, name: 'Action')], 
    id: 130392,
    name: "The DAmelio Show",
    originalLanguage: "en",
    originalName: "The DAmelio Show",
    overview:
        "From relative obscurity",
    popularity: 25.383,
    posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
    voteAverage: 9,
    voteCount: 3134,
    numberOfEpisodes: 18,
    numberOfSeasons: 2,
    );

final testWatchlistTv = Tv.watchlist(
  id: 130392,
  name: "The DAmelio Show",
  posterPath: '/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg',
  overview: "From relative obscurity",
);

final testTvTable = TvTable(
  id: 130392,
  name: "The DAmelio Show",
  posterPath: '/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg',
  overview: "From relative obscurity",
);

final testTvMap = {
  'id': 130392,
  'name': 'The DAmelio Show',
  'posterPath': '/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg',
  'overview': 'From relative obscurity'
  };