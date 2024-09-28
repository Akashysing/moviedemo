import 'package:flutter/material.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';
import 'package:kettomovie/utils/shared/ui_factory.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onClick;

  const ButtonWidget({
    required this.title,
    super.key,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onClick,
        icon: const Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        label: UIFactory().textConfiguration(AppStrings.watchTrailer,
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
