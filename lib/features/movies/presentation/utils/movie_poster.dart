import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/movies/presentation/utils/no_image_avaliable.dart';
import 'package:cine_scope/features/movies/presentation/utils/skeleton_placeholder.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.posterPath});

  final String? posterPath;

  @override
  Widget build(BuildContext context) {
    const shadowDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
      ],
    );

    return posterPath == null
        ? _ErrorWidget(shadowDecoration: shadowDecoration)
        : CachedNetworkImage(
            imageUrl: posterPath!,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SkeletonPlaceholder(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: shadowDecoration.boxShadow,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) =>
                _ErrorWidget(shadowDecoration: shadowDecoration),
          );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.shadowDecoration});

  final BoxDecoration shadowDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.surfaceContainerHighest,
        boxShadow: shadowDecoration.boxShadow,
      ),
      child: const Center(child: NoImageAvaliable()),
    );
  }
}
