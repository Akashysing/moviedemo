class AppImages {
  static final AppImages _instance = AppImages._internal();

  AppImages._internal();

  factory AppImages() {
    return _instance;
  }

  final String movieErrorPlaceHolder = 'assets/images/png/movieError.png';
}
