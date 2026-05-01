import 'dart:io';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource_impl.dart';
import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

String fixture(String name) =>
    File('test/fixtures/$name.json').readAsStringSync();

void main() {
  late MockHttpClient mockHttpClient;
  late MovieRemoteDatasourceImpl movieRemoteDatasource;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    movieRemoteDatasource = MovieRemoteDatasourceImpl(
      httpClient: mockHttpClient,
      apiKey: 'fake_api_key',
      language: 'en-US',
    );
  });

  group('movie list tests', () {
    test('should return a list of movies when status code is 200', () async {
      final fakeResponse = fixture('popular_movies');

      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await movieRemoteDatasource.getPopularMovies();

      expect(result, isA<List<MovieSummaryModel>>());
      expect(result.length, 2);
    });

    test('should return exception when status code is not 200', () async {
      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response('error', 400));

      expect(() => movieRemoteDatasource.getPopularMovies(), throwsException);
    });

    test('should return only valid movies when json is invalid', () async {
      final fakeResponse = fixture('invalid_movies_list');

      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await movieRemoteDatasource.getPopularMovies();

      expect(result, isA<List<MovieSummaryModel>>());
      expect(result.length, 2);
    });

    test(
      'should return an empty list when page limit is exceeded (API status_code 22)',
      () async {
        final fakeResponse = fixture('invalid_page_response');

        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer((_) async => http.Response(fakeResponse, 400));

        final result = await movieRemoteDatasource.getPopularMovies(page: 501);

        expect(result.length, 0);
      },
    );
  });

  group('movie details tests', () {
    test('should return a movie when status code is 200', () async {
      final fakeResponse = fixture('movie_details');

      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await movieRemoteDatasource.getMovieById(id: 550);

      expect(result, isA<MovieModel>());
      expect(result.id, 550);
      expect(result.title, 'Fight Club');
    });

    test('should return exception when status code is not 200', () async {
      when(
        () => mockHttpClient.get(any()),
      ).thenAnswer((_) async => http.Response('error', 400));

      expect(
        () => movieRemoteDatasource.getMovieById(id: 550),
        throwsException,
      );
    });
  });
}
