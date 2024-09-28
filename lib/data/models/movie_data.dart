import 'package:intl/intl.dart';
import 'package:kettomovie/data/models/cast_data.dart';
import 'package:kettomovie/data/models/credits_data.dart';
import 'package:kettomovie/data/models/recommendations_movie_data.dart';
import 'package:kettomovie/data/models/release_dates_data.dart';
import 'package:kettomovie/data/models/videos_data.dart';
import 'package:kettomovie/utils/constants/app_api_endpoints.dart';

class MovieData {
  final int? id;
  final String? posterPath;
  final double? score;
  final String? title;
  final String? releaseDate;
  final int? runtime;
  final String? overview;
  final CreditsData? credits;
  final RecommendationsMovieData? recommendations;
  final VideosData? videos;
  final ReleaseDatesData? releaseDates;

  String get formattedPercentage {
    return '${((score ?? 0) * 10).toStringAsFixed(0)}%';
  }

  String get getMoviePosterPath => posterPath?.isNotEmpty ?? false
      ? '${APIEndPoints().tmdbImageBaseURL}$posterPath'
      : '';

  String get movieReleaseData => releaseDate?.isNotEmpty ?? false
      ? DateFormat('dd/MM/yyyy').format(DateTime.parse(releaseDate!))
      : '';

  String get movieCertification {
    if (releaseDates?.results != null &&
        (releaseDates?.results?.isNotEmpty ?? false)) {
      return releaseDates!.results?.first.iso31661 ?? '';
    }
    return '';
  }

  List<CastData>? get getCastActressList =>
      credits?.cast?.where((CastData cast) => cast.gender == 1).toList();

  List<ResultData>? get getRecommendationList =>
      recommendations?.results?.toList();

  String get getYoutubeTrailer {
    if (videos != null) {
      if (videos?.results?.isNotEmpty ?? false) {
        VideosResultData? video = videos?.results?.firstWhere(
          (video) =>
              video.site?.toLowerCase() == 'youtube' &&
              video.type?.toLowerCase() == 'trailer',
          orElse: () => VideosResultData(),
        );
        return 'https://www.youtube.com/watch?v=${video?.key} ?? ' '';
      }
    }
    return '';
  }

  String get movieDuration {
    int? hours;
    int? minutes;

    if (runtime != 0) {
      hours = runtime! ~/ 60;
      minutes = runtime! % 60;
      return '${hours}h ${minutes}m';
    }
    return '';
  }

  MovieData({
    this.id,
    this.posterPath,
    this.score,
    this.title,
    this.releaseDate,
    this.runtime,
    this.overview,
    this.credits,
    this.recommendations,
    this.videos,
    this.releaseDates,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      id: json['id'] ?? 0,
      posterPath: json['poster_path'] ?? '',
      score: json['vote_average'] ?? 0.0,
      title: json['title'] ?? '',
      runtime: json['runtime'] ?? 0,
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      credits: json["credits"] == null
          ? null
          : CreditsData.fromJson(json["credits"]),
      recommendations: json["recommendations"] == null
          ? null
          : RecommendationsMovieData.fromJson(json["recommendations"]),
      videos:
          json["videos"] == null ? null : VideosData.fromJson(json["videos"]),
      releaseDates: json["release_dates"] == null
          ? null
          : ReleaseDatesData.fromJson(json["release_dates"]),
    );
  }
}
