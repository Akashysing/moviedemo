class MovieData {
  final int? id;
  final String? posterPath;
  final double? score;
  final String? title;
  final String? releaseDate;
  final int? runtime;
  final String? overview;
  final Credits? credits;
  final Recommendations? recommendations;
  final Videos? videos;
  final ReleaseDates? releaseDates;

  String get getMoviePosterPath => posterPath?.isNotEmpty ?? false
      ? 'https://image.tmdb.org/t/p/w500/$posterPath'
      : '';

  String get movieCertification {
    if (releaseDates?.results != null &&
        (releaseDates?.results?.isNotEmpty ?? false)) {
      return releaseDates!.results?.first.iso31661 ?? '';
    }
    return '';
  }

  String get getCastActressString =>
      credits?.cast
          ?.where((Cast cast) => cast.gender == 1)
          .map((Cast cast) => cast.name ?? '')
          .join(', ') ??
      '';

  String get getRecommendationString =>
      recommendations?.results
          ?.map((Result result) => result.title ?? '')
          .toList()
          .join(', ') ??
      '';

  String get getYoutubeTrailer {
    if (videos != null) {
      if (videos?.results?.isNotEmpty ?? false) {
        VideosResult? video = videos?.results?.firstWhere(
          (video) =>
              video.site?.toLowerCase() == 'youtube' &&
              video.type?.toLowerCase() == 'trailer',
          orElse: () => VideosResult(),
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
      credits:
          json["credits"] == null ? null : Credits.fromJson(json["credits"]),
      recommendations: json["recommendations"] == null
          ? null
          : Recommendations.fromJson(json["recommendations"]),
      videos: json["videos"] == null ? null : Videos.fromJson(json["videos"]),
      releaseDates: json["release_dates"] == null
          ? null
          : ReleaseDates.fromJson(json["release_dates"]),
    );
  }
}

class Recommendations {
  List<Result>? results;

  Recommendations({
    this.results,
  });
  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      Recommendations(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );
}

class Result {
  String? title;

  Result({
    this.title,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
      );
}

class Credits {
  List<Cast>? cast;

  Credits({
    this.cast,
  });
  factory Credits.fromJson(Map<String, dynamic> json) => Credits(
        cast: json["cast"] == null
            ? []
            : List<Cast>.from(json["cast"]!.map((x) => Cast.fromJson(x))),
      );
}

class Cast {
  String? name;
  int? gender;
  Cast({
    this.name,
    this.gender,
  });
  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json["name"],
        gender: json["gender"],
      );
}

class Videos {
  List<VideosResult>? results;

  Videos({
    this.results,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        results: json["results"] == null
            ? []
            : List<VideosResult>.from(
                json["results"]!.map((x) => VideosResult.fromJson(x))),
      );
}

class VideosResult {
  String? name;
  String? key;
  String? site;
  String? type;

  VideosResult({
    this.name,
    this.key,
    this.site,
    this.type,
  });

  factory VideosResult.fromJson(Map<String, dynamic> json) => VideosResult(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
      );
}

class ReleaseDates {
  List<ReleaseDatesResult>? results;

  ReleaseDates({
    this.results,
  });

  factory ReleaseDates.fromJson(Map<String, dynamic> json) => ReleaseDates(
        results: json["results"] == null
            ? []
            : List<ReleaseDatesResult>.from(
                json["results"]!.map((x) => ReleaseDatesResult.fromJson(x))),
      );
}

class ReleaseDatesResult {
  String? iso31661;
  List<ReleaseDate>? releaseDates;

  ReleaseDatesResult({this.iso31661, this.releaseDates});

  factory ReleaseDatesResult.fromJson(Map<String, dynamic> json) =>
      ReleaseDatesResult(
        iso31661: json["iso_3166_1"],
        releaseDates: json["release_dates"] == null
            ? []
            : List<ReleaseDate>.from(
                json["release_dates"]!.map((x) => ReleaseDate.fromJson(x))),
      );
}

class ReleaseDate {
  String? certification;
  List<String>? descriptors;
  String? iso6391;
  String? note;
  String? releaseDate;
  int? type;

  ReleaseDate({
    this.certification,
    this.descriptors,
    this.iso6391,
    this.note,
    this.releaseDate,
    this.type,
  });
  factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
        certification: json["certification"],
        descriptors: json["descriptors"] == null
            ? []
            : List<String>.from(json["descriptors"]!.map((x) => x)),
        iso6391: json["iso_639_1"],
        note: json["note"],
        releaseDate: json["release_date"],
        type: json["type"],
      );
}
