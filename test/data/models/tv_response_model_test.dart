import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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
      voteCount: 3134);
      
  final tTvResponse = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_show_airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/99vBORZixICa32Pwdwj0lWcr8K.jpg",
            "first_air_date": "2021-09-03",
            "genre_ids": [10764],
            "id": 130392,
            "name": "The DAmelio Show",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "The DAmelio Show",
            "overview":
                "From relative obscurity",
            "popularity": 25.383,
            "poster_path": "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
            "vote_average": 9,
            "vote_count": 3134
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
