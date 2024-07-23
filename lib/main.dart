import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokedex_get/app/modules/detail/controllers/detail_controller.dart';

import 'app/modules/detail/bindings/detail_binding.dart';
import 'app/modules/detail/views/detail_view.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/modules/splash/controllers/splash_controller.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final splashController = Get.put(SplashController());
  final detailController = Get.put(DetailController());
  final homeController = Get.put(HomeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        title: 'Flutter Demo',
     //   theme: homeController.isDark.value ?? false ? ThemeData.dark() : ThemeData.light(), // Provide a default value or handle null safely
        initialRoute: Routes.SPLASH,
        getPages: [
          GetPage(name: Routes.SPLASH, page: () => SplashView(), binding: SplashBinding()),
          GetPage(name: Routes.HOME, page: () => HomeView(), binding: HomeBinding()),
         // GetPage(name: Routes.DETAIL, page: () => DetailView(), binding: DetailBinding()),

        ],
    );
  }

}