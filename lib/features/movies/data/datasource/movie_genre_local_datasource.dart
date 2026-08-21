import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieGenreLocalDataSource {
  Future<Map<int, String>?> getCachedMovieGenres(String language);

  Future<void> cacheMovieGenres(
    String language,
    Map<int, String> genres,
  );
}

class MovieGenreLocalDataSourceImpl implements MovieGenreLocalDataSource {
  final SharedPreferences _prefs;

  MovieGenreLocalDataSourceImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  String _getCacheKey(String language) => 'movie_genres_$language';

  @override
  Future<Map<int, String>?> getCachedMovieGenres(String language) async {
    final key = _getCacheKey(language);
    final jsonString = _prefs.getString(key);

    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return jsonMap.map((key, value) => MapEntry(int.parse(key), value as String));
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> cacheMovieGenres(
    String language,
    Map<int, String> genres,
  ) async {
    final key = _getCacheKey(language);
    final jsonMap = genres.map((key, value) => MapEntry(key.toString(), value));
    await _prefs.setString(key, jsonEncode(jsonMap));
  }
}
