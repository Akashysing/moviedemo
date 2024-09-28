import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIFactory {
  static final UIFactory _instance = UIFactory._internal();

  UIFactory._internal();

  factory UIFactory() {
    return _instance;
  }

  final Widget horizontalSpaceTiny = const SizedBox(width: 5.0);
  final Widget horizontalSpaceSmall = const SizedBox(width: 8.0);
  final Widget horizontalSpaceRegular = const SizedBox(width: 18.0);
  final Widget horizontalSpaceMedium = const SizedBox(width: 25.0);
  final Widget horizontalSpaceLarge = const SizedBox(width: 50.0);
  final Widget horizontalSpaceExtraLarge = const SizedBox(width: 140.0);

  final Widget verticalSpaceTiny = const SizedBox(height: 5.0);
  final Widget verticalSpaceSmall = const SizedBox(height: 8.0);
  final Widget verticalSpaceRegular = const SizedBox(height: 18.0);
  final Widget verticalSpaceMedium = const SizedBox(height: 25.0);
  final Widget verticalSpaceMediumlarge = const SizedBox(height: 34.0);
  final Widget verticalSpaceLarge = const SizedBox(height: 50.0);

  Widget textConfiguration(String text,
      {Color? color,
      double? fontSize,
      FontWeight fontWeight = FontWeight.w600,
      FontStyle fontStyle = FontStyle.normal,
      int? maxLines,
      TextAlign? textAlign = TextAlign.start}) {
    color = color ?? Colors.white;
    fontSize = fontSize ?? 12;
    maxLines = maxLines;

    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
  }

  void showSnackbar(String title, String message,
      {Color backgroundColor = Colors.red}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
