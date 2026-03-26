import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalDatasourceImpl implements MovieLocalDatasource {
  final SharedPreferences _prefs;

  MovieLocalDatasourceImpl({required SharedPreferences prefs}) : _prefs = prefs;

  @override
  Future<void> addFavorite(int id) async {
    try {
      final list = _prefs.getStringList('favorites') ?? [];
      if (list.contains(id.toString())) {
        return;
      }
      list.add(id.toString());

      await _prefs.setStringList('favorites', list);
    } catch (e) {
      throw Exception('Error adding movie to favorites');
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    try {
      final list = _prefs.getStringList('favorites') ?? [];
      list.remove(id.toString());
      await _prefs.setStringList('favorites', list);
    } catch (e) {
      throw Exception('Error removing movie from favorites');
    }
  }

  @override
  List<int> getFavorites() {
    final stringList = _prefs.getStringList('favorites') ?? [];
    return stringList.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> addToWatchList(int id) async {
    try {
      final list = _prefs.getStringList('watch_list') ?? [];
      if (list.contains(id.toString())) {
        return;
      }
      list.add(id.toString());
      await _prefs.setStringList('watch_list', list);
    } catch (e) {
      throw Exception('Error adding movie to watch list');
    }
  }

  @override
  Future<void> removeFromWatchList(int id) async {
    try {
      final list = _prefs.getStringList('watch_list') ?? [];
      list.remove(id.toString());
      await _prefs.setStringList('watch_list', list);
    } catch (e) {
      throw Exception('Error removing movie from watch list');
    }
  }

  @override
  List<int> getWatchList() {
    final stringList = _prefs.getStringList('watch_list') ?? [];
    return stringList.map((e) => int.parse(e)).toList();
  }
}
