class APIEndPoints {
  APIEndPoints._internal();

  static final APIEndPoints _instance = APIEndPoints._internal();

  factory APIEndPoints() {
    return _instance;
  }
  String baseURL = 'https://api.themoviedb.org/3';
  String apiKey = '7647a0a758efcd293d48b84cbe31295a';
  String tmdbImageBaseURL = 'https://image.tmdb.org/t/p/w500/';
}
