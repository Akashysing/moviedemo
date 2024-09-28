class ReleaseDatesData {
  List<ReleaseDatesResultsData>? results;

  ReleaseDatesData({
    this.results,
  });

  factory ReleaseDatesData.fromJson(Map<String, dynamic> json) =>
      ReleaseDatesData(
        results: json["results"] == null
            ? []
            : List<ReleaseDatesResultsData>.from(json["results"]!
                .map((x) => ReleaseDatesResultsData.fromJson(x))),
      );
}

class ReleaseDatesResultsData {
  String? iso31661;
  List<ReleaseDateData>? releaseDates;

  ReleaseDatesResultsData({this.iso31661, this.releaseDates});

  factory ReleaseDatesResultsData.fromJson(Map<String, dynamic> json) =>
      ReleaseDatesResultsData(
        iso31661: json["iso_3166_1"],
        releaseDates: json["release_dates"] == null
            ? []
            : List<ReleaseDateData>.from(
                json["release_dates"]!.map((x) => ReleaseDateData.fromJson(x))),
      );
}

class ReleaseDateData {
  String? certification;
  List<String>? descriptors;
  String? iso6391;
  String? note;
  String? releaseDate;
  int? type;

  ReleaseDateData({
    this.certification,
    this.descriptors,
    this.iso6391,
    this.note,
    this.releaseDate,
    this.type,
  });
  factory ReleaseDateData.fromJson(Map<String, dynamic> json) =>
      ReleaseDateData(
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
