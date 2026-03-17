// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieLocalModelAdapter extends TypeAdapter<MovieLocalModel> {
  @override
  final int typeId = 0;

  @override
  MovieLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieLocalModel(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String,
      backdropPath: fields[4] as String,
      voteAverage: fields[5] as double,
      voteCount: fields[6] as int,
      releaseDate: fields[7] as String,
      genres: (fields[8] as List).cast<(int, String)>(),
      originalLanguage: fields[9] as String,
      popularity: fields[10] as double,
      adult: fields[11] as bool,
      isFavorite: fields[12] as bool,
      isInWatchLater: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieLocalModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.voteCount)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.originalLanguage)
      ..writeByte(10)
      ..write(obj.popularity)
      ..writeByte(11)
      ..write(obj.adult)
      ..writeByte(12)
      ..write(obj.isFavorite)
      ..writeByte(13)
      ..write(obj.isInWatchLater);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
