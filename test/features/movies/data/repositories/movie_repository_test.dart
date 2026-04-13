import 'dart:convert';

import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../datasource/movie_remote_datasource_test.dart';

class MockMovieRemoteDatasource extends Mock implements MovieRemoteDatasource {}

class MockMovieLocalDatasource extends Mock implements MovieLocalDatasource {}

void main() {
  late MockMovieRemoteDatasource mockMovieRemoteDatasource;
  late MockMovieLocalDatasource mockMovieLocalDatasource;
  late MovieRepositoryImpl movieRepository;

  setUp(() {
    mockMovieRemoteDatasource = MockMovieRemoteDatasource();
    mockMovieLocalDatasource = MockMovieLocalDatasource();
    movieRepository = MovieRepositoryImpl(
      remoteDatasource: mockMovieRemoteDatasource,
      localDatasource: mockMovieLocalDatasource,
    );
  });

  group('favorite movies test', () {
    test('should return a list of favorite movies', () async {
      //local datasource arrange
      final fakeIds = [1, 2];

      when(
        () => mockMovieLocalDatasource.getFavorites(),
      ).thenAnswer((_) => fakeIds);

      //remote datasource arrange
      final fakeMovie = MovieModel.fromJson(
        jsonDecode(fixture('movie_details')),
      );

      when(
        () => mockMovieRemoteDatasource.getMovieById(id: 1),
      ).thenAnswer((_) async => fakeMovie);

      when(
        () => mockMovieRemoteDatasource.getMovieById(id: 2),
      ).thenAnswer((_) async => fakeMovie);

      //act
      final result = await movieRepository.getFavoriteMovies();

      //assert
      expect(result, isA<List<MovieSummary>>());
      expect(result.length, 2);
    });

    test('should return only valid movies when json is invalid', () async {
      //arrange
      final fakeInvalidMovie = fixture('invalid_movie_details');

      final fakeMovie = fixture('movie_details');

      when(() => mockMovieRemoteDatasource.getMovieById(id: 1)).thenAnswer(
        (_) async => MovieModel.fromJson(jsonDecode(fakeInvalidMovie)),
      );

      when(
        () => mockMovieRemoteDatasource.getMovieById(id: 2),
      ).thenAnswer((_) async => MovieModel.fromJson(jsonDecode(fakeMovie)));

      when(
        () => mockMovieLocalDatasource.getFavorites(),
      ).thenAnswer((_) => [1, 2]);

      //act
      final result = await movieRepository.getFavoriteMovies();

      //assert
      expect(result, isA<List<MovieSummary>>());
      expect(result.length, 1);
    });
  });

  test('should return a list of movies in watchlist', () async {
    //local datasource arrange
    final fakeIds = [1, 2];

    when(
      () => mockMovieLocalDatasource.getWatchList(),
    ).thenAnswer((_) => fakeIds);

    //remote datasource arrange
    final fakeMovie = MovieModel.fromJson(jsonDecode(fixture('movie_details')));

    when(
      () => mockMovieRemoteDatasource.getMovieById(id: 1),
    ).thenAnswer((_) async => fakeMovie);

    when(
      () => mockMovieRemoteDatasource.getMovieById(id: 2),
    ).thenAnswer((_) async => fakeMovie);

    //act
    final result = await movieRepository.getWatchListMovies();

    //assert
    expect(result, isA<List<MovieSummary>>());
    expect(result.length, 2);
  });
}
