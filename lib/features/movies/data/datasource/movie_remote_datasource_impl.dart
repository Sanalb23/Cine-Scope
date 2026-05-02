import 'dart:convert';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client _httpClient;
  final String _apiKey;
  final String _language;

  MovieRemoteDatasourceImpl({
    required http.Client httpClient,
    required String apiKey,
    required String language,
  }) : _httpClient = httpClient,
       _apiKey = apiKey,
       _language = language;

  final String _baseUrl = 'https://api.themoviedb.org/3';

  final String _baseImageUrl = 'https://image.tmdb.org/t/p/';
  final String _posterSize = 'w500';
  final String _backdropSize = 'w1280';

  String _buildImageUrl(String path, String size) {
    return '$_baseImageUrl$size$path';
  }

  String? _buildTrailerUrl(List<dynamic>? results) {
    if (results == null || results.isEmpty) return null;

    try {
      final trailer = results.firstWhere(
        (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
      );
      return 'https://www.youtube.com/watch?v=${trailer['key']}';
    } catch (_) {
      return null;
    }
  }

  Future<String?> _getTrailerPathById({required int id}) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/movie/$id/videos?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return _buildTrailerUrl(data['results']);
    }

    return null;
  }

  Future<MovieModel> _buildMovieModel(Map<String, dynamic> json) async {
    final movie = MovieModel.fromJson(json);

    var trailerPath = _buildTrailerUrl(json['videos']?['results'] as List?);

    trailerPath ??= await _getTrailerPathById(id: movie.id);

    return movie.copyWith(
      posterPath: movie.posterPath != null
          ? _buildImageUrl(movie.posterPath!, _posterSize)
          : null,
      backdropPath: movie.backdropPath != null
          ? _buildImageUrl(movie.backdropPath!, _backdropSize)
          : null,
      trailerPath: trailerPath,
    );
  }

  @override
  Future<List<MovieSummaryModel>> getPopularMovies({int page = 1}) async {
    return await getMoviesList(
      path: '/movie/popular?api_key=$_apiKey&language=$_language&page=$page',
    );
  }

  @override
  Future<List<MovieSummaryModel>> getTopRatedMovies({int page = 1}) async {
    return await getMoviesList(
      path: '/movie/top_rated?api_key=$_apiKey&language=$_language&page=$page',
    );
  }

  @override
  Future<List<MovieSummaryModel>> getUpcomingMovies({int page = 1}) async {
    final DateTime now = DateTime.now();

    final String gte = '${now.year}-${now.month}-${now.day}';

    final DateTime lteDateTime = now.add(const Duration(days: 30));
    final String lte =
        '${lteDateTime.year}-${lteDateTime.month}-${lteDateTime.day}';

    return await getMoviesList(
      path:
          '/discover/movie?api_key=$_apiKey&language=$_language&primary_release_date.gte=$gte&primary_release_date.lte=$lte&page=$page',
    );
  }

  @override
  Future<List<MovieSummaryModel>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    return await getMoviesList(
      path:
          '/search/movie?api_key=$_apiKey&language=$_language&query=$query&page=$page',
    );
  }

  @override
  Future<MovieModel> getMovieById({required int id}) async {
    final response = await _httpClient.get(
      Uri.parse(
        '$_baseUrl/movie/$id?api_key=$_apiKey&language=$_language&append_to_response=videos',
      ),
    );
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return _buildMovieModel(data);
      } catch (_) {
        throw Exception('Failed to load movie');
      }
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  Future<List<MovieSummaryModel>> getSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    return await getMoviesList(
      path:
          '/movie/$id/similar?api_key=$_apiKey&language=$_language&page=$page',
    );
  }

  Future<List<MovieSummaryModel>> getMoviesList({required String path}) async {
    MovieSummaryModel buildMovieSummaryModel(Map<String, dynamic> json) {
      final movie = MovieSummaryModel.fromJson(json);
      return movie.copyWith(
        posterPath: movie.posterPath != null
            ? _buildImageUrl(movie.posterPath!, _posterSize)
            : null,
      );
    }

    final response = await _httpClient.get(Uri.parse('$_baseUrl$path'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if ((data['results'] as List).isEmpty) {
        return [];
      }

      final List<MovieSummaryModel> movies = [];
      for (final x in data['results'] as List) {
        try {
          movies.add(buildMovieSummaryModel(x));
        } catch (_) {
          // Ignore element if parsing fails
        }
      }
      return movies;
    } else {
      try {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status_code'] == 22) {
          return [];
        }
      } catch (_) {
        // Fall back to default exception if response is not valid JSON
      }
      throw Exception('Failed to load movies');
    }
  }
}
