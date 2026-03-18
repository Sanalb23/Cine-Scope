import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.autoDispose
    .family<List<MovieSummary>, int>((ref, id) async {
      return ref.read(movieRepositoryProvider).getSimilarMovies(id: id);
    });
