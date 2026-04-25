// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSummaryModel _$MovieSummaryModelFromJson(Map<String, dynamic> json) =>
    MovieSummaryModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      posterPath: json['posterPath'] as String?,
      voteAverage: (json['voteAverage'] as num).toDouble(),
      releaseDate: DateTime.parse(json['releaseDate'] as String),
      genreIds: (json['genreIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      adult: json['adult'] as bool,
    );

// ignore: unused_element
Map<String, dynamic> _$MovieSummaryModelToJson(MovieSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'posterPath': instance.posterPath,
      'voteAverage': instance.voteAverage,
      'releaseDate': instance.releaseDate.toIso8601String(),
      'genreIds': instance.genreIds,
      'adult': instance.adult,
    };
