import 'dart:convert';

import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TmdbDatasource {
  final String apiKey = dotenv.env['TMDB_API_KEY']!;

  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> searchMovie({required String query}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieModel> getMovieById({required int id}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<List<MovieModel>> getSimilarMovies({required int id}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/$id/similar?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((x) => MovieModel.fromJson(x))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
