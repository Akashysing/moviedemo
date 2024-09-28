import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kettomovie/routes/app_pages.dart';
import 'package:kettomovie/constants/app_strings.dart';
import 'package:kettomovie/constants/enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutesEnum.home.route,
      title: AppStrings.movieApp,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      getPages: AppPages().routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
