import 'package:get/get.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/data/models/recommendations_movie_data.dart';
import 'package:kettomovie/services/connectivity_service.dart';
import 'package:kettomovie/services/movie_service.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';
import 'package:kettomovie/utils/shared/ui_factory.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsController extends GetxController {
  // initialize variable
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorString = RxString('');
  String get errorString => _errorString.value;

  final Rx<MovieData?> _movieDetails = (null as MovieData?).obs;
  MovieData? get movieDetails => _movieDetails.value;

  final RxInt _movieId = 0.obs;
  int get movieId => _movieId.value;

  @override
  Future<void> onInit() async {
    getArgument();
    fetchMovieDetails(movieId); // ApiCall with passing movieId arguments
    super.onInit();
  }

// getting previous screen passed arguments
  void getArgument() async {
    if (Get.arguments != null) {
      _movieId.value = Get.arguments['movieId'];
    }
  }

//Previous screen navigation
  void backButtonClick() {
    Get.back();
  }

//Fetch Movie Details
  void fetchMovieDetails(int movieId) async {
    _isLoading(true);
    await MovieService().getMovieDetails(
        movieId: movieId,
        onSuccess: (MovieData movieDetails) {
          _movieDetails.value = movieDetails;
          _isLoading(false);
        },
        onFailed: (String error) {
          _errorString.value = error;
          _isLoading(false);
        });
  }

//Navigate to youtube using url launcher package
  onTappedWatchTrailer(String yTtrailerLink) async {
    if ((!Get.find<ConnectivityService>().isConnected)) {
      return UIFactory().showSnackbar(
          AppStrings.noInternetConnection, AppStrings.youAreCurrentlyoffline);
    }
    final Uri url = Uri.parse(yTtrailerLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeMovieSelection(ResultData movie) {
    if ((!Get.find<ConnectivityService>().isConnected)) {
      return UIFactory().showSnackbar(
          AppStrings.noInternetConnection, AppStrings.youAreCurrentlyoffline);
    }
    fetchMovieDetails(movie.id ?? 0); // ApiCall with passing movieId arguments
  }
}
