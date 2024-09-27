import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/modules/movie_dashboard/controller/movie_dashboard_controller.dart';
import 'package:kettomovie/modules/movie_dashboard/views/movie_card.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';

class MovieDashboardView extends GetView<MovieDashboardController> {
  const MovieDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            AppStrings.movieApp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildSection(
                    AppStrings.popularMovies, controller.popularMovies),
                _buildSection(
                    AppStrings.topRatedMovies, controller.topRatedMovies),
                _buildSection(
                    AppStrings.upcomingMovies, controller.upcomingMovies),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildSection(String title, List<MovieData> movies) {
    return Visibility(
      replacement: const SizedBox.shrink(),
      visible: movies.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                MovieData movie = movies[index];
                return GestureDetector(
                    onTap: () {
                      controller.navigateToMovieDetailsScreen(movie.id);
                    },
                    child: MovieCard(movie: movie));
              },
            ),
          ),
        ],
      ),
    );
  }
}
