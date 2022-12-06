import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
    TvDetailModel({
        required this.adult,
        required this.backdropPath, 
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.lastAirDate,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    final bool? adult;
    final String? backdropPath; 
    final String firstAirDate;
    final List<GenreModel> genres;
    final String? homepage;
    final int id;
    final bool? inProduction;
    final String? lastAirDate;
    final String name;
    final int? numberOfEpisodes;
    final int? numberOfSeasons;
    final String? originalLanguage;
    final String? originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final String? status;
    final String? tagline;
    final String? type;
    final double voteAverage;
    final int? voteCount;

    factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"]??"", 
        firstAirDate: json["first_air_date"] ?? "",
        genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"] ?? "",
        id: json["id"] ?? "",
        inProduction: json["in_production"] ?? false,
        lastAirDate: json["last_air_date"] ?? "",
        name: json["name"] ?? "",
        numberOfEpisodes: json["number_of_episodes"] ?? 0,
        numberOfSeasons: json["number_of_seasons"] ?? "",
        originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? "",
        status: json["status"] ?? "",
        tagline: json["tagline"] ?? "",
        type: json["type"] ?? "",
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath, 
        "first_air_date": firstAirDate,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "last_air_date": lastAirDate,
        "name": name,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
    
    TvDetail toEntity() {
      return TvDetail(
          backdropPath: this.backdropPath,
          firstAirDate: this.firstAirDate,
          genres: this.genres.map((genre) => genre.toEntity()).toList(),
          id: this.id,
          name: this.name,
          originalLanguage: this.originalLanguage,
          originalName: this.originalName,
          overview: this.overview,
          popularity: this.popularity,
          posterPath: this.posterPath,
          voteAverage: this.voteAverage,
          voteCount: this.voteCount,
          numberOfEpisodes: this.numberOfEpisodes,
          numberOfSeasons: this.numberOfSeasons,
      );
    }
  @override
  List<Object?> get props => [
      adult,
      backdropPath, 
      firstAirDate,
      genres,
      homepage,
      id,
      inProduction,
      lastAirDate, 
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
      ];
} 