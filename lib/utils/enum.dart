enum AppRoutesEnum {
  movieDashboard(route: '/movieDashboard'),
  movieDetail(route: '/movieDetail');

  const AppRoutesEnum({
    required this.route,
  });

  // final int numberValue;
  final String route;
}
