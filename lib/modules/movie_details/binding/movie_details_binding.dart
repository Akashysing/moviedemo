import 'package:kettomovie/modules/movie_details/controller/movie_details_controller.dart';
import 'package:get/get.dart';

class MovieDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailsController>(
      () => MovieDetailsController(),
    );
  }
}
