class VideosData {
  List<VideosResultData>? results;

  VideosData({
    this.results,
  });

  factory VideosData.fromJson(Map<String, dynamic> json) => VideosData(
        results: json["results"] == null
            ? []
            : List<VideosResultData>.from(
                json["results"]!.map((x) => VideosResultData.fromJson(x))),
      );
}

class VideosResultData {
  String? name;
  String? key;
  String? site;
  String? type;

  VideosResultData({
    this.name,
    this.key,
    this.site,
    this.type,
  });

  factory VideosResultData.fromJson(Map<String, dynamic> json) =>
      VideosResultData(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
      );
}
