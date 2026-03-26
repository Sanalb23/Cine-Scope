import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';

abstract class MovieLocalDatasource {
  Future<void> addFavorite(MovieLocalModel movie);
  Future<void> removeFavorite(int id);
  List<MovieLocalModel> getFavorites();

  Future<void> addToWatchList(MovieLocalModel movie);
  Future<void> removeFromWatchList(int id);
  List<MovieLocalModel> getWatchList();

  MovieLocalModel? getMovieById({required int id});
}
