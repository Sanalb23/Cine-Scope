import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/loading_poster_image.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.posterPath});

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    const shadowDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
      ],
    );

    return CachedNetworkImage(
      imageUrl: posterPath,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoadingPosterImage(),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: shadowDecoration.boxShadow,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colors.surfaceContainerHighest,
          boxShadow: shadowDecoration.boxShadow,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            spacing: AppSpacing.sm,
            children: [
              const Icon(Icons.error),
              Text('No Image available', style: context.textTheme.labelSmall),
            ],
          ),
        ),
      ),
    );
  }
}
