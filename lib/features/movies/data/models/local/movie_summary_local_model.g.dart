// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieSummaryLocalModelAdapter
    extends TypeAdapter<MovieSummaryLocalModel> {
  @override
  final int typeId = 1;

  @override
  MovieSummaryLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieSummaryLocalModel(
      id: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String,
      voteAverage: fields[3] as double,
      releaseDate: fields[4] as String,
      genreIds: (fields[5] as List).cast<int>(),
      adult: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieSummaryLocalModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.genreIds)
      ..writeByte(6)
      ..write(obj.adult);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieSummaryLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
