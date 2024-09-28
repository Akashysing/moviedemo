import 'package:kettomovie/data/models/cast_data.dart';

class CreditsData {
  List<CastData>? cast;

  CreditsData({
    this.cast,
  });
  factory CreditsData.fromJson(Map<String, dynamic> json) => CreditsData(
        cast: json["cast"] == null
            ? []
            : List<CastData>.from(
                json["cast"]!.map((x) => CastData.fromJson(x))),
      );
}
