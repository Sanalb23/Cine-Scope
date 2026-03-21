import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum.dart';
import 'package:flutter/material.dart';

extension MovieListCategoryEnumExtensions on MovieListCategory {
  String get title {
    return switch (this) {
      MovieListCategory.popular => 'Popular',
      MovieListCategory.topRated => 'Top Rated',
    };
  }

  IconData get icon {
    return switch (this) {
      MovieListCategory.popular => Icons.local_fire_department,
      MovieListCategory.topRated => Icons.star,
    };
  }
}
