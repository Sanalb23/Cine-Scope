import 'dart:convert';
import 'package:cine_scope/features/movies/data/datasource/movie_datasource.dart';
import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:http/http.dart' as http;

class TmdbDatasource implements MovieDatasource {
  final http.Client httpClient;
  final String apiKey;

  TmdbDatasource({required this.httpClient, required this.apiKey});

  final String baseUrl = 'https://api.themoviedb.org/3';

  @override
  Future<List<MovieSummaryModel>> getPopularMovies({int page = 1}) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieSummaryModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieSummaryModel>> getTopRatedMovies({int page = 1}) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieSummaryModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<List<MovieSummaryModel>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    final response = await httpClient.get(
      Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page',
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieSummaryModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Future<MovieModel> getMovieById({required int id}) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  Future<List<MovieSummaryModel>> getSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/movie/$id/similar?api_key=$apiKey&page=$page'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieSummaryModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
