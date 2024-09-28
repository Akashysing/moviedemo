import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kettomovie/constants/app_images.dart';
import 'package:kettomovie/modules/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _bottomNavItem(AppImages().homeIcon),
          _bottomNavItem(AppImages().trendingIcon),
          _bottomNavItem(AppImages().favouriteIcon),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavItem(String iconAsset) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconAsset,
        height: 20,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      label: '',
    );
  }
}
