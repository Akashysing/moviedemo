import 'package:get/get.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/services/movie_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsController extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final Rx<MovieData?> _movieDetails = (null as MovieData?).obs;
  MovieData? get movieDetails => _movieDetails.value;

  final RxInt _movieId = 0.obs;
  int get movieId => _movieId.value;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  void getArgument() {
    if (Get.arguments != null) {
      _movieId.value = Get.arguments['movieId'];
      fetchMovieDetails(Get.arguments['movieId']);
    }
  }

  void fetchMovieDetails(int movieId) async {
    _isLoading(true);
    await MovieService().getMovieDetails(
        movieId: movieId,
        onSuccess: (MovieData movieDetails) {
          _movieDetails.value = movieDetails;
          _isLoading(false);
        },
        onFailed: (String error) {
          _isLoading(false);
        });
  }

  void onTappedWatchTrailer(String yTtrailerLink) async {
    final Uri url = Uri.parse(yTtrailerLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
