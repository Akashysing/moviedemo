class AppStrings {
  AppStrings._internal();

  static final AppStrings _instance = AppStrings._internal();

  factory AppStrings() {
    return _instance;
  }
  static const String movieApp = 'Ketto Movie';
  static const String popularMovies = 'Popular Movies';
  static const String topRatedMovies = 'Top Rated Movies';
  static const String upcomingMovies = 'Upcoming Movies';
  static const String overview = 'Overview';
  static const String castActress = 'Cast Actress';
  static const String recommendations = 'Recommendations';
  static const String watchTrailer = 'Watch Trailer';
  static const String youAreCurrentlyoffline = 'You are currently offline';
  static const String noInternetConnection = 'No Internet Connection';
}
