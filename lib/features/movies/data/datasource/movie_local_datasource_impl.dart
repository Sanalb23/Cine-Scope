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
    await _favoritesBox.put(movie.id, movie);
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _favoritesBox.delete(id);
  }

  @override
  bool isFavorite(int id) {
    return _favoritesBox.containsKey(id);
  }

  @override
  List<MovieLocalModel> getFavorites() {
    return _favoritesBox.values.toList();
  }

  @override
  Future<void> addWatchLater(MovieLocalModel movie) async {
    await _watchLaterBox.put(movie.id, movie);
  }

  @override
  Future<void> removeWatchLater(int id) async {
    await _watchLaterBox.delete(id);
  }

  @override
  bool isInWatchLater(int id) {
    return _watchLaterBox.containsKey(id);
  }

  @override
  List<MovieLocalModel> getWatchLater() {
    return _watchLaterBox.values.toList();
  }

  @override
  MovieLocalModel? getMovieById({required int id}) {
    return _favoritesBox.get(id) ?? _watchLaterBox.get(id);
  }
}
