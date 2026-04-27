import 'package:cine_scope/features/movies/data/repositories/movie_repository.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
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
        searchMoviesProvider.overrideWith2(
          (arg) => SearchMoviesNotifier(
            arg,
            preloadPostersFn: (movies) async => movies,
          ),
        ),
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
          releaseDate: DateTime.parse('2010-07-15'),
          genreIds: [28],
          adult: false,
        ),
      ];

      when(
        () => mockMovieRepository.searchMovie(query: query),
      ).thenAnswer((_) async => expectedMovies);

      final subscription = container.listen(
        searchMoviesProvider(query),
        (_, __) {},
      );

      final result = await container.read(searchMoviesProvider(query).future);

      expect(result, expectedMovies);

      verify(() => mockMovieRepository.searchMovie(query: query)).called(1);

      subscription.close();
    });
  });
}
