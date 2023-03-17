import 'package:get/get.dart';

import '../data/repositories/popular_product_repo.dart';
import '../modals/popular_product_response_modal.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;



  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      print("GET PRODUTCS DATA!");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList[0].image.toString());
      print(_popularProductList[0].name.toString());
      _isLoaded = true;
      update();
    }else{
      _isLoaded = false;
      print('Error : ${response.body} with response code : ${response.statusCode}');
    }
  }
}