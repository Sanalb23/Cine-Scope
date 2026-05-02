import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension MovieListCategoryEnumExtensions on MovieListCategory {
  String get title {
    return switch (this) {
      MovieListCategory.popular => 'popular'.tr(),
      MovieListCategory.topRated => 'top_rated'.tr(),
      MovieListCategory.upcoming => 'upcoming'.tr(),
    };
  }

  IconData get icon {
    return switch (this) {
      MovieListCategory.popular => Icons.local_fire_department,
      MovieListCategory.topRated => Icons.star,
      MovieListCategory.upcoming => Icons.event,
    };
  }
}
