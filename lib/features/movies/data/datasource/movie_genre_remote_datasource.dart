import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieGenreRemoteDataSource {
  final http.Client _httpClient;
  final String _apiKey;

  MovieGenreRemoteDataSource({
    required http.Client httpClient,
    required String apiKey,
  }) : _httpClient = httpClient,
       _apiKey = apiKey;

  String _baseUrl(String language) =>
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey&language=$language';

  Future<Map<int, String>> getMovieGenres({required String language}) async {
    final response = await _httpClient.get(Uri.parse(_baseUrl(language)));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Map<int, String>.fromEntries(
        (data['genres'] as List).map(
          (genre) => MapEntry<int, String>(genre['id'], genre['name']),
        ),
      );
    } else {
      throw Exception('Failed to load movie genres');
    }
  }
}
