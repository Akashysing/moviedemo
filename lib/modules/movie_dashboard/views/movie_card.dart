import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/utils/shared/common_shimmer_container.dart';

class MovieCard extends StatelessWidget {
  final MovieData movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: 180,
            width: 140,
            fit: BoxFit.cover,
            imageUrl: movie.getMoviePosterPath,
            placeholder: (context, url) => const Center(
              child: CommonShimmerContainer(
                width: double.maxFinite,
                height: double.maxFinite,
              ),
            ),
          ),
        ));
  }
}
