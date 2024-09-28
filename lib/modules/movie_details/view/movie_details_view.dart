import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kettomovie/data/models/cast_data.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/data/models/recommendations_movie_data.dart';
import 'package:kettomovie/modules/movie_details/controller/movie_details_controller.dart';

import 'package:kettomovie/utils/constants/app_images.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';
import 'package:kettomovie/utils/shared/button_widget.dart';
import 'package:kettomovie/utils/shared/common_shimmer_container.dart';
import 'package:kettomovie/utils/shared/ui_factory.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  const MovieDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121212),
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Hero animation showing
                Stack(
                  children: [
                    Hero(
                      tag: controller.movieId,
                      child: CachedNetworkImage(
                        height: 300,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        imageUrl: Get.arguments['movieURL'],
                        errorWidget: (context, url, error) => Image.asset(
                            // Movie Error PlaceHolder showing
                            AppImages().movieErrorPlaceHolder,
                            fit: BoxFit.cover),
                        placeholder: (context, url) => const Center(
                          child: CommonShimmerContainer(
                            // Shimmer animation showing
                            width: double.maxFinite,
                            height: double.maxFinite,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.backButtonClick();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(
                  () {
                    final movie = controller.movieDetails;
                    if (!controller.isLoading &&
                        controller.errorString.isNotEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: UIFactory().textConfiguration(
                          controller.errorString,
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isLoading
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 80.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UIFactory().verticalSpaceTiny,
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
                                          UIFactory().textConfiguration(
                                            '${movie?.title ?? ''}(${movie?.movieCertification})',
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                UIFactory().verticalSpaceTiny,
                                Row(
                                  children: [
                                    // Score
                                    UIFactory().textConfiguration(
                                      '${movie?.getScoreInPercentage} match',
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    UIFactory().horizontalSpaceSmall,
                                    //Release data
                                    UIFactory().textConfiguration(
                                        '${movie?.movieReleaseData}',
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    UIFactory().horizontalSpaceSmall,
                                    //Duration
                                    UIFactory().textConfiguration(
                                        '${movie?.movieDuration}',
                                        color: Colors.grey[700],
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                                // Watch Trailer
                                Visibility(
                                  replacement: const SizedBox.shrink(),
                                  visible:
                                      movie?.getYoutubeTrailer.isNotEmpty ??
                                          false,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: ButtonWidget(
                                        title: AppStrings.watchTrailer,
                                        onClick: () =>
                                            controller.onTappedWatchTrailer(
                                                movie!.getYoutubeTrailer),
                                      )),
                                ),
                                // overview
                                Visibility(
                                  visible: movie?.overview?.isNotEmpty ?? false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        UIFactory().textConfiguration(
                                            AppStrings.overview,
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        UIFactory().textConfiguration(
                                            movie?.overview ?? '',
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                  ),
                                ),
                                // Get Cast Actress List
                                Visibility(
                                  replacement: const SizedBox.shrink(),
                                  visible:
                                      movie?.getCastActressList?.isNotEmpty ??
                                          false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UIFactory().textConfiguration(
                                          AppStrings.castActress,
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      _castOverviewListUI(movie),
                                    ],
                                  ),
                                ),
                                // Recommendations
                                Visibility(
                                  replacement: const SizedBox.shrink(),
                                  visible: movie
                                          ?.getRecommendationList?.isNotEmpty ??
                                      false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UIFactory().textConfiguration(
                                          AppStrings.recommendations,
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      _recommendationListUI(movie)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

Widget _castOverviewListUI(MovieData? movie) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: movie?.getCastActressList?.length,
          itemBuilder: (context, index) {
            CastData castActress =
                movie?.getCastActressList?[index] ?? CastData();
            return SizedBox(
              width: 100,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      imageUrl: castActress.getCastActressPosterPath,
                      errorWidget: (context, url, error) => Image.asset(
                          AppImages().castActressPlaceHolder,
                          fit: BoxFit.cover),
                      placeholder: (context, url) => const Center(
                        child: CommonShimmerContainer(
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                  UIFactory().verticalSpaceSmall,
                  UIFactory().textConfiguration(castActress.originalName ?? '',
                      color: Colors.white,
                      fontSize: 14,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold),
                  UIFactory().textConfiguration(castActress.character ?? '',
                      color: Colors.grey,
                      fontSize: 14,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400),
                ],
              ),
            );
          },
        ),
      ));
}

Widget _recommendationListUI(MovieData? movie) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      height: 250,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movie?.getRecommendationList?.length,
        itemBuilder: (context, index) {
          ResultData recomMovie =
              movie?.getRecommendationList?[index] ?? ResultData();
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    width: 110,
                    height: 160,
                    fit: BoxFit.cover,
                    imageUrl: recomMovie.getRecommMoviePosterPath,
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
                UIFactory().verticalSpaceTiny,
                UIFactory().textConfiguration(recomMovie.originalTitle ?? '',
                    color: Colors.white,
                    fontSize: 14,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold),
                UIFactory().verticalSpaceTiny,
              ],
            ),
          );
        },
      ),
    ),
  );
}
