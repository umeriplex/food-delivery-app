import 'package:get/get.dart';

import '../views/cart/cart_page.dart';
import '../views/food/popular_food_details.dart';
import '../views/food/recomended_food_details.dart';
import '../views/home/home_page.dart';
import '../views/home/main_food_view.dart';
import '../views/splash/splash_view.dart';

class RouteHelper {

  // TODO .......::::::::::::: PAGE NAMES :::::::::::..............
  static const String initial = "/";
  static String getInitial()=> initial;

  static const String popularFood = "/popular_food";
  static String getPopularFood(int pageID,String page)=> '$popularFood?pageID=$pageID&page=$page';

  static const String recommendedFood = "/recommended_food";
  static String getRecommendedFood(int pageID,String page)=> '$recommendedFood?pageID=$pageID&page=$page';

  static const String cartView = "/cart_view";
  static String getCartView()=> cartView;


  static const String splashView = "/splah_view";
  static String getSplashView()=> splashView;

  // TODO .......:::::::::: ROUTES ::::::::::...............

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomePage()),

    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageID'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(pageId: int.parse(pageId.toString()),page: page.toString(),);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageID'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(pageId: int.parse(pageId.toString()),page: page.toString(),);
        },
        transition: Transition.fadeIn),

    GetPage(name: cartView, page: () => const CartView(), transition: Transition.downToUp),

    GetPage(name: splashView, page: () => const SplashView(), transition: Transition.fade),

  ];
}
