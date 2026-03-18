import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;
  late ProviderContainer container;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    container = ProviderContainer(
      overrides: [
        movieRepositoryProvider.overrideWithValue(mockMovieRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('search movies provider test', () {
    test('should return empty list when query is empty', () async {
      final result = await container.read(searchMoviesProvider('').future);

      expect(result, isEmpty);

      verifyNever(
        () => mockMovieRepository.searchMovie(query: any(named: 'query')),
      );
    });

    test('should return movies when query is not empty', () async {
      const query = 'Inception';
      final expectedMovies = [
        MovieSummary(
          id: 1,
          title: 'Inception',
          posterPath: '/path.jpg',
          voteAverage: 8.8,
          releaseDate: '2010-07-15',
          genreIds: [28],
          adult: false,
        ),
      ];

      when(
        () => mockMovieRepository.searchMovie(query: query),
      ).thenAnswer((_) async => expectedMovies);

      final subscription = container.listen(
        searchMoviesProvider(query),
        (previous, next) {},
      );

      final result = await container.read(searchMoviesProvider(query).future);
      expect(result, expectedMovies);

      verify(() => mockMovieRepository.searchMovie(query: query)).called(1);

      subscription.close();
    });
  });
}
