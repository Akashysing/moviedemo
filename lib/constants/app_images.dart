class AppImages {
  static final AppImages _instance = AppImages._internal();

  AppImages._internal();

  factory AppImages() {
    return _instance;
  }

  final String homeIcon = 'assets/images/svg/home.svg';
  final String trendingIcon = 'assets/images/svg/flame.svg';
  final String settingIcon = 'assets/images/svg/settings.svg';
  final String favouriteIcon = 'assets/images/svg/heart.svg';
  final String movieErrorPlaceHolder = 'assets/images/png/movieError.png';
}
