import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource_impl.dart';
import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final movieLocalDatasourceProvider = Provider.autoDispose<MovieLocalDatasource>(
  (ref) {
    final favoritesBox = Hive.box<MovieLocalModel>('favorites');
    final watchLaterBox = Hive.box<MovieLocalModel>('watchLater');
    return MovieLocalDatasourceImpl(
      favoritesBox: favoritesBox,
      watchLaterBox: watchLaterBox,
    );
  },
);
