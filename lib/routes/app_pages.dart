import 'package:get/get.dart';
import 'package:kettomovie/modules/movie_dashboard/binding/movie_dashboard_binding.dart';
import 'package:kettomovie/modules/movie_dashboard/views/movie_dashboard_view.dart';
import 'package:kettomovie/modules/movie_details/binding/movie_details_binding.dart';
import 'package:kettomovie/modules/movie_details/view/movie_details_view.dart';
import 'package:kettomovie/utils/enum.dart';

class AppPages {
  AppPages._internal();

  static final AppPages _instance = AppPages._internal();

  factory AppPages() {
    return _instance;
  }

  final routes = [
    GetPage(
      name: AppRoutesEnum.movieDashboard.route,
      page: () => const MovieDashboardView(),
      binding: MovieDashboardBinding(),
    ),
    GetPage(
      name: AppRoutesEnum.movieDetail.route,
      page: () => const MovieDetailsView(),
      binding: MovieDetailsBinding(),
    ),
  ];
}
