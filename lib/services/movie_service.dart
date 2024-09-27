import 'package:get/get.dart';
import 'package:kettomovie/data/models/movie_data.dart';
import 'package:kettomovie/utils/constants/app_api_endpoints.dart';

class MovieService extends GetConnect {
  Future<void> getMovies({
    required String category,
    required Function(List<MovieData> movieData) onSuccess,
    required Function(String error) onFailed,
  }) async {
    try {
      final response = await get(
          '${APIEndPoints().baseURL}/movie/$category?api_key=${APIEndPoints().apiKey}');

      if (response.status.hasError) {
        return onFailed(
            'Error fetching $category movies: ${response.statusCode}');
      } else {
        List<MovieData> movieList = [];
        Map<String, dynamic> responseMap = response.body;

        if (responseMap.containsKey('results') &&
            responseMap['results'] != null) {
          for (Map<String, dynamic> result in responseMap['results']) {
            MovieData mData = MovieData.fromJson(result);
            movieList.add(mData);
          }
        }
        onSuccess(movieList);
      }
      return;
    } catch (e) {
      return onFailed('Exception occurred: $e');
    }
  }

  Future<void> getMovieDetails({
    required int movieId,
    required Function(MovieData movieDetails) onSuccess,
    required Function(String error) onFailed,
  }) async {
    try {
      final response = await get(
          '${APIEndPoints().baseURL}/movie/$movieId?api_key=${APIEndPoints().apiKey}&append_to_response=videos,credits,recommendations,release_dates,certification');
      if (response.status.hasError) {
        return onFailed(
            'Error fetching Get Movie Details: ${response.statusText}');
      } else {
        Map<String, dynamic> responseMap = response.body;

        onSuccess(MovieData.fromJson(responseMap));
      }
      return;
    } catch (e) {
      return onFailed('Exception occurred: $e');
    }
  }
}
