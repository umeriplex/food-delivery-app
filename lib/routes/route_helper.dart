import 'package:get/get.dart';

import '../views/food/popular_food_details.dart';
import '../views/food/recomended_food_details.dart';
import '../views/home/main_food_view.dart';

class RouteHelper {

  // TODO .......::::::::::::: PAGE NAMES :::::::::::..............
  static const String initial = "/";
  static String getInitial()=> initial;

  static const String popularFood = "/popular_food";
  static String getPopularFood(int pageID)=> '$popularFood?pageID=$pageID';

  static const String recommendedFood = "/recommended_food";
  static String getRecommendedFood(int pageID)=> '$recommendedFood?pageID=$pageID';

  // TODO .......:::::::::: ROUTES ::::::::::...............

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainFoodView()),

    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageID'];
          return PopularFoodDetails(pageId: int.parse(pageId.toString()),);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageID'];
          return RecommendedFoodDetails(pageId: int.parse(pageId.toString()));
        },
        transition: Transition.fadeIn),
  ];
}
