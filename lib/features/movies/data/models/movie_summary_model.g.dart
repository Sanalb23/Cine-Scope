// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSummaryModel _$MovieSummaryModelFromJson(Map<String, dynamic> json) =>
    MovieSummaryModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: DateTime.parse(json['release_date'] as String),
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );
