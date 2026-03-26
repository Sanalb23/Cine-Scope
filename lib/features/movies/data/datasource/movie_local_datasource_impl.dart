import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MovieLocalDatasourceImpl implements MovieLocalDatasource {
  final Box<MovieLocalModel> _favoritesBox;
  final Box<MovieLocalModel> _watchLaterBox;

  MovieLocalDatasourceImpl({
    required Box<MovieLocalModel> favoritesBox,
    required Box<MovieLocalModel> watchLaterBox,
  }) : _favoritesBox = favoritesBox,
       _watchLaterBox = watchLaterBox;

  @override
  Future<void> addFavorite(MovieLocalModel movie) async {
    try {
      await _favoritesBox.put(movie.id, movie);
    } catch (e) {
      throw Exception('Error adding movie to favorites');
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    try {
      await _favoritesBox.delete(id);
    } catch (e) {
      throw Exception('Error removing movie from favorites');
    }
  }

  @override
  List<MovieLocalModel> getFavorites() {
    return _favoritesBox.values.toList();
  }

  @override
  Future<void> addToWatchList(MovieLocalModel movie) async {
    try {
      await _watchLaterBox.put(movie.id, movie);
    } catch (e) {
      throw Exception('Error adding movie to watch list');
    }
  }

  @override
  Future<void> removeFromWatchList(int id) async {
    try {
      await _watchLaterBox.delete(id);
    } catch (e) {
      throw Exception('Error removing movie from watch list');
    }
  }

  @override
  List<MovieLocalModel> getWatchList() {
    return _watchLaterBox.values.toList();
  }

  @override
  MovieLocalModel? getMovieById({required int id}) {
    return _favoritesBox.get(id) ?? _watchLaterBox.get(id);
  }
}
