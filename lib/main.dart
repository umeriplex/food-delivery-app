import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_odering_app/controllers/cart_controller.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/views/food/popular_food_details.dart';
import 'package:food_odering_app/views/food/recomended_food_details.dart';
import 'package:food_odering_app/views/home/main_food_view.dart';
import 'package:food_odering_app/views/splash/splash_view.dart';
import 'package:get/get.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_food_controller.dart';
import 'di/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedFoodController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.getSplashView(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
