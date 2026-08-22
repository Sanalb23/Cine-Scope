import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomeBody {
  home,
  favorites,
  watchList,
  about,
}

final homeBodyProvider = NotifierProvider<HomeBodyNotifier, HomeBody>(
  HomeBodyNotifier.new,
);

class HomeBodyNotifier extends Notifier<HomeBody> {
  @override
  HomeBody build() {
    return HomeBody.home;
  }

  void switchHomeBody(HomeBody body) {
    state = body;
  }
}
