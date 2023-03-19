import 'package:get/get.dart';

import '../data/repositories/popular_product_repo.dart';
import '../modals/cart_modal.dart';
import '../modals/popular_product_response_modal.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("GET PRODUTCS DATA!");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList[0].image.toString());
      print(_popularProductList[0].name.toString());
      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
      print(
          'Error : ${response.body} with response code : ${response.statusCode}');
    }
  }

  // TODO ......::::::::::::: CART SYSTEM :::::::::::::::........
  int _quantity = 0;

  int get quantity => _quantity;
  int _cartItems = 0;

  int get cartItems => _cartItems + _quantity;
  late CartController _cartController;

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_cartItems + quantity) < 0) {
      Get.snackbar("Item Count", "you can`t reduce more!");
      if(_cartItems>0){
        _quantity = - _cartItems;
        return _quantity;
      }
      return 0;
    } else if ((_cartItems + quantity) > 20) {
      Get.snackbar("Max Item Reached", "you can`t add more then 20.");
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cartController, ProductModal product) {
    _quantity = 0;
    _cartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.isExistInCart(product);
    if (exist) {
      _cartItems = _cartController.getQuantity(product);
    }
    print("THE QUANTITY IN CART IS: $_cartItems");

    print("exist or not ? $exist");
  }

  void addItem(ProductModal product) {
    _cartController.addItem(product, _quantity);

    _quantity = 0;
    _cartItems = _cartController.getQuantity(product);

    _cartController.items.forEach((key, value) {
      print("The ID is: $key The Quantity is: ${value.quantity}");
    });
    update();
  }

  int get getTotalItems {
    return _cartController.totalItems;
  }

  List<CartModal> get getItems{
      return _cartController.cartItems;
  }
}
