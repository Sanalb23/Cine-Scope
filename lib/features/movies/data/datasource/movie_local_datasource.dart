import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';

abstract class MovieLocalDatasource {
  Future<void> addFavorite(MovieLocalModel movie);
  Future<void> removeFavorite(int id);
  bool isFavorite(int id);
  List<MovieLocalModel> getFavorites();

  Future<void> addWatchLater(MovieLocalModel movie);
  Future<void> removeWatchLater(int id);
  bool isInWatchLater(int id);
  List<MovieLocalModel> getWatchLater();
}
