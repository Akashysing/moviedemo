import 'package:kettomovie/utils/constants/app_api_endpoints.dart';

class RecommendationsMovieData {
  List<ResultData>? results;

  RecommendationsMovieData({
    this.results,
  });
  factory RecommendationsMovieData.fromJson(Map<String, dynamic> json) =>
      RecommendationsMovieData(
        results: json["results"] == null
            ? []
            : List<ResultData>.from(
                json["results"]!.map((x) => ResultData.fromJson(x))),
      );
}

class ResultData {
  String? title;
  String? originalTitle;
  String? posterPath;
  ResultData({
    this.title,
    this.originalTitle,
    this.posterPath,
  });

  String get getRecommMoviePosterPath => posterPath?.isNotEmpty ?? false
      ? '${APIEndPoints().tmdbImageBaseURL}$posterPath'
      : '';

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        title: json["title"] ?? '',
        originalTitle: json["title"] ?? '',
        posterPath: json["poster_path"] ?? '',
      );
}
