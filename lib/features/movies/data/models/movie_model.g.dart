// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  releaseDate: DateTime.parse(json['release_date'] as String),
  genres: (json['genres'] as List<dynamic>)
      .map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            id: ($jsonValue['id'] as num).toInt(),
            name: $jsonValue['name'] as String,
          ),
        ),
      )
      .toList(),
  originalLanguage: json['original_language'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  runtime: (json['runtime'] as num).toInt(),
);

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
