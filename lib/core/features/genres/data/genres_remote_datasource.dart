import 'dart:convert';
import 'package:http/http.dart' as http;

class GenresRemoteDataSource {
  final http.Client _httpClient;
  final String _apiKey;

  GenresRemoteDataSource({
    required http.Client httpClient,
    required String apiKey,
  }) : _httpClient = httpClient,
       _apiKey = apiKey;

  String get _baseUrl =>
      'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey';

  Future<Map<int, String>> getMovieGenres() async {
    final response = await _httpClient.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Map<int, String>.from(
        data['genres'].map((x) => MapEntry(x['id'], x['name'])),
      );
    } else {
      throw Exception('Failed to load movie genres');
    }
  }
}
