import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kettomovie/routes/app_pages.dart';
import 'package:kettomovie/services/connectivity_service.dart';
import 'package:kettomovie/utils/constants/app_strings.dart';
import 'package:kettomovie/utils/enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX and the ConnectivityService
  await Get.putAsync(() async => ConnectivityService(), permanent: true);
  await Get.find<ConnectivityService>().onInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutesEnum.movieDashboard.route,
      initialBinding: null,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: AppStrings.movieApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages().routes,
    );
  }
}
