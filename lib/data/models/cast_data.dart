import 'package:kettomovie/utils/constants/app_api_endpoints.dart';

class CastData {
  String? character;
  int? gender;
  String? profilePath;
  String? originalName;
  CastData({
    this.character,
    this.gender,
    this.profilePath,
    this.originalName,
  });

  String get getCastActressPosterPath => profilePath?.isNotEmpty ?? false
      ? '${APIEndPoints().tmdbImageBaseURL}$profilePath'
      : '';

  factory CastData.fromJson(Map<String, dynamic> json) => CastData(
        character: json["character"],
        gender: json["gender"],
        profilePath: json["profile_path"],
        originalName: json["original_name"],
      );
}
