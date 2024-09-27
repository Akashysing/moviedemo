import 'package:get/get.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/services/movie_service.dart';
import 'package:kettomovie/utils/enum.dart';

class MovieDashboardController extends GetxController {
  final RxList<MovieData> _popularMovies = <MovieData>[].obs;
  List<MovieData> get popularMovies => _popularMovies;

  final RxList<MovieData> _topRatedMovies = <MovieData>[].obs;
  List<MovieData> get topRatedMovies => _topRatedMovies;

  final RxList<MovieData> _upcomingMovies = <MovieData>[].obs;
  List<MovieData> get upcomingMovies => _upcomingMovies;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final MovieService movieService = MovieService();

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
    fetchTopRatedMovies();
    fetchUpcomingMovies();
  }

  void navigateToMovieDetailsScreen(MovieData movie) {
    Get.toNamed(
      AppRoutesEnum.movieDetail.route,
      arguments: <String, dynamic>{
        'movieId': movie.id,
        'movieURL': movie.getMoviePosterPath
      },
    );
  }

  void fetchPopularMovies() async {
    _isLoading(true);

    await movieService.getMovies(
        category: 'popular',
        onSuccess: (List<MovieData> movieList) {
          popularMovies.addAll(movieList);
          _isLoading(false);
        },
        onFailed: (String error) {
          _isLoading(false);
          Future.error(error);
        });
  }

  void fetchTopRatedMovies() async {
    _isLoading(true);
    await movieService.getMovies(
        category: 'top_rated',
        onSuccess: (List<MovieData> movieList) {
          topRatedMovies.addAll(movieList);
          _isLoading(false);
        },
        onFailed: (String error) {
          _isLoading(false);
          Future.error(error);
        });
  }

  void fetchUpcomingMovies() async {
    _isLoading(true);
    await movieService.getMovies(
        category: 'upcoming',
        onSuccess: (List<MovieData> movieList) {
          upcomingMovies.addAll(movieList);
          _isLoading(false);
        },
        onFailed: (String error) {
          _isLoading(false);
          Future.error(error);
        });
  }
}
