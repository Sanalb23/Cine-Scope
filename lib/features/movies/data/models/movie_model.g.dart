// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterPath: json['posterPath'] as String?,
  backdropPath: json['backdropPath'] as String?,
  voteAverage: (json['voteAverage'] as num).toDouble(),
  voteCount: (json['voteCount'] as num).toInt(),
  releaseDate: DateTime.parse(json['releaseDate'] as String),
  genres: (json['genres'] as List<dynamic>)
      .map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) =>
              (($jsonValue[r'$1'] as num).toInt(), $jsonValue[r'$2'] as String),
        ),
      )
      .toList(),
  originalLanguage: json['originalLanguage'] as String,
  popularity: (json['popularity'] as num).toDouble(),
  adult: json['adult'] as bool,
  runtime: (json['runtime'] as num).toInt(),
);

// ignore: unused_element
Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'genres': instance.genres
          .map((e) => <String, dynamic>{r'$1': e.$1, r'$2': e.$2})
          .toList(),
      'originalLanguage': instance.originalLanguage,
      'popularity': instance.popularity,
      'adult': instance.adult,
      'runtime': instance.runtime,
    };

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);
