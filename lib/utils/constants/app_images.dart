class AppImages {
  static final AppImages _instance = AppImages._internal();

  AppImages._internal();

  factory AppImages() {
    return _instance;
  }

  // API Images Constant
  final String movieErrorPlaceHolder = 'assets/images/png/movieError.png';
  final String castActressPlaceHolder =
      'assets/images/png/castActressPlaceHolder.png';
}
