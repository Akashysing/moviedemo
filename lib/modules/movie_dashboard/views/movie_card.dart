import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/utils/constants/app_images.dart';
import 'package:kettomovie/utils/shared/common_shimmer_container.dart';

class MovieCard extends StatelessWidget {
  final MovieData movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.white, width: 0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Hero(
            tag: movie.id ?? '',
            child: CachedNetworkImage(
              height: 180,
              width: 140,
              fit: BoxFit.cover,
              imageUrl: movie.getMoviePosterPath,
              errorWidget: (context, url, error) => Image.asset(
                  AppImages().movieErrorPlaceHolder,
                  fit: BoxFit.cover),
              placeholder: (context, url) => const Center(
                child: CommonShimmerContainer(
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
              ),
            ),
          ),
        ));
  }
}
