import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/location_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_food_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repositories/auth_repo.dart';
import '../data/repositories/cart_repo.dart';
import '../data/repositories/location_repo.dart';
import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_food_repo.dart';
import '../data/repositories/user_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async {

  // TODO ........::::::::::: SHARED PREFERENCES :::::::::::.........
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // TODO ........::::::::::: API CLIENT :::::::::::.........
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));


  // TODO ........::::::::::: REPOSITORIES :::::::::::.........
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()), fenix: true);
  Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(),apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => UserRepo(apiClient: Get.find()),fenix: true);
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(),prefs: Get.find()),fenix: true);



  // TODO ........::::::::::: CONTROLLERS :::::::::::.........
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()), fenix: true);
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()), fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
  Get.lazyPut(() => AuthController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UserController(userRepo: Get.find()), fenix: true);
  Get.lazyPut(() => LocationController(locationRepo: Get.find()), fenix: true);
}
