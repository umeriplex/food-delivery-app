import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/repositories/popular_product_repo.dart';
import '../data/repositories/recommended_food_repo.dart';
import '../modals/popular_product_response_modal.dart';

class RecommendedFoodController extends GetxController {
  final RecommendedFoodRepo recommendedFoodRepo;
  RecommendedFoodController({required this.recommendedFoodRepo});

  List<dynamic> _recommendedFoodList = [];
  List<dynamic> get recommendedFoodList => _recommendedFoodList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;



  Future<void> getRecommendedFoodList() async{
    Response response = await recommendedFoodRepo.getRecommendedFoodList();
    if(response.statusCode == 200){
      if (kDebugMode) {
        print("GET RECOMMENDED DATA!");
      }
      _recommendedFoodList = [];
      _recommendedFoodList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{
      _isLoaded = false;
      if (kDebugMode) {
        print('Error : ${response.body} with response code : ${response.statusCode}');
      }
    }
  }


}