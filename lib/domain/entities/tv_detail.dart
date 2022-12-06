import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
      required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      
  });

  final String? backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double? popularity;
  final String posterPath;
  final double voteAverage;
  final int? voteCount;
  final int? numberOfEpisodes;

  final int? numberOfSeasons;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        numberOfEpisodes,
        numberOfSeasons,
      ];
}