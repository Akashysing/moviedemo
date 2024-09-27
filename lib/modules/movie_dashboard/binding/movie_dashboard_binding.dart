import 'package:get/get.dart';
import 'package:kettomovie/modules/movie_dashboard/controller/movie_dashboard_controller.dart';

class MovieDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDashboardController>(
      () => MovieDashboardController(),
    );
  }
}
