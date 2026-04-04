import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/movies/presentation/utils/no_image_avaliable.dart';
import 'package:cine_scope/features/movies/presentation/utils/skeleton_placeholder.dart';
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
      placeholder: (context, url) => const SkeletonPlaceholder(),
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
        child: const Center(child: NoImageAvaliable()),
      ),
    );
  }
}
