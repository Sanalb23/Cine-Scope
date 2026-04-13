import 'dart:convert';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client _httpClient;
  final String _apiKey;

  MovieRemoteDatasourceImpl({
    required http.Client httpClient,
    required String apiKey,
  }) : _httpClient = httpClient,
       _apiKey = apiKey;

  final String _baseUrl = 'https://api.themoviedb.org/3';

  final String _baseImageUrl = 'https://image.tmdb.org/t/p/';
  final String _posterSize = 'w500';
  final String _backdropSize = 'w1280';

  String _buildImageUrl(String path, String size) {
    return '$_baseImageUrl$size$path';
  }

  MovieSummaryModel _buildMovieSummaryModel(Map<String, dynamic> json) {
    final movie = MovieSummaryModel.fromJson(json);
    return movie.copyWith(
      posterPath: movie.posterPath != null
          ? _buildImageUrl(movie.posterPath!, _posterSize)
          : null,
    );
  }

  MovieModel _buildMovieModel(Map<String, dynamic> json) {
    final movie = MovieModel.fromJson(json);
    return movie.copyWith(
      posterPath: movie.posterPath != null
          ? _buildImageUrl(movie.posterPath!, _posterSize)
          : null,
      backdropPath: movie.backdropPath != null
          ? _buildImageUrl(movie.backdropPath!, _backdropSize)
          : null,
    );
  }

  @override
  Future<List<MovieSummaryModel>> getPopularMovies({int page = 1}) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<MovieSummaryModel> movies = [];
      for (final x in data['results'] as List) {
        try {
          movies.add(_buildMovieSummaryModel(x));
        } catch (_) {
          // Ignore element if parsing fails
        }
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieSummaryModel>> getTopRatedMovies({int page = 1}) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<MovieSummaryModel> movies = [];
      for (final x in data['results'] as List) {
        try {
          movies.add(_buildMovieSummaryModel(x));
        } catch (_) {
          // Ignore element if parsing fails
        }
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieSummaryModel>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    final response = await _httpClient.get(
      Uri.parse(
        '$_baseUrl/search/movie?api_key=$_apiKey&query=$query&page=$page',
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<MovieSummaryModel> movies = [];
      for (final x in data['results'] as List) {
        try {
          movies.add(_buildMovieSummaryModel(x));
        } catch (_) {
          // Ignore element if parsing fails
        }
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<MovieModel> getMovieById({required int id}) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/movie/$id?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return _buildMovieModel(data);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  Future<List<MovieSummaryModel>> getSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/movie/$id/similar?api_key=$_apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<MovieSummaryModel> movies = [];
      for (final x in data['results'] as List) {
        try {
          movies.add(_buildMovieSummaryModel(x));
        } catch (_) {
          // Ignore element if parsing fails
        }
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
