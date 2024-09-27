import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kettomovie/modules/movie_details/controller/movie_details_controller.dart';
import 'package:kettomovie/utils/constants/app_images.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';
import 'package:kettomovie/utils/shared/common_shimmer_container.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  const MovieDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text(
              AppStrings.movieDetails,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: controller.movieId,
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: Get.arguments['movieURL'],
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
              Obx(
                () {
                  final movie = controller.movieDetails;
                  return controller.isLoading
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${movie?.title ?? ''}(${movie?.movieCertification})',
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${AppStrings.releaseDate} ${movie?.movieReleaseData}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${AppStrings.score} ${movie?.score?.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _richText(
                                      title: AppStrings.runtime,
                                      description: movie?.movieDuration),
                                  Visibility(
                                    replacement: const SizedBox.shrink(),
                                    visible:
                                        movie?.getYoutubeTrailer.isNotEmpty ??
                                            false,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (movie?.getYoutubeTrailer
                                                .isNotEmpty ??
                                            false) {
                                          controller.onTappedWatchTrailer(
                                              movie!.getYoutubeTrailer);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        AppStrings.watchTrailer,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Overview
                              _richText(
                                  title: AppStrings.overview,
                                  description: movie?.overview),

                              // Cast
                              _richText(
                                  title: AppStrings.cast,
                                  description: movie?.getCastActressString),
                              // Recommendations
                              _richText(
                                  title: AppStrings.recommendations,
                                  description: movie?.getRecommendationString),
                            ],
                          ),
                        );
                },
              )
            ],
          ),
        ));
  }
}

Widget _richText({required String? title, required String? description}) {
  return Visibility(
    replacement: const SizedBox.shrink(),
    visible: description?.isNotEmpty ?? false,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' $description',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
