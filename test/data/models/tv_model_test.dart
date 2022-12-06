import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
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
    voteCount: 3134
  );

  final tTv = Tv(
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
    voteCount: 3134
  );

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
