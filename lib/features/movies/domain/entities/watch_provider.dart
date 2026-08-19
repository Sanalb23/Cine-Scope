enum WatchProviderType {
  flatrate,
  rent,
  buy,
  ads,
  free,
}

class WatchProvider {
  final int id;
  final String name;
  final String? logoPath;

  const WatchProvider({
    required this.id,
    required this.name,
    this.logoPath,
  });
}
