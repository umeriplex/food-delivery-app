import 'package:get/get.dart';

import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_food_controller.dart';
import '../data/api/api_client.dart';
import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_food_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {
  // TODO ........::::::::::: API CLIENT :::::::::::.........
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));


  // TODO ........::::::::::: REPOSITORIES :::::::::::.........
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));



  // TODO ........::::::::::: CONTROLLERS :::::::::::.........
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
}
