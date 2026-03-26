abstract class MovieLocalDatasource {
  Future<void> addFavorite(int id);
  Future<void> removeFavorite(int id);
  List<int> getFavorites();

  Future<void> addToWatchList(int id);
  Future<void> removeFromWatchList(int id);
  List<int> getWatchList();
}
