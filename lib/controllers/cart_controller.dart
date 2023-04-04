import 'package:flutter/cupertino.dart';
import 'package:food_odering_app/modals/cart_modal.dart';
import 'package:food_odering_app/modals/popular_product_response_modal.dart';
import 'package:get/get.dart';
import '../data/repositories/cart_repo.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModal> _items = {};
  Map<int, CartModal> get items => _items;

  List<CartModal> storageCartItems = [];

  void addItem(ProductModal product, int quantity) {

    var totalQuantity = 0;


    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (existingItem) {
        print("UPDATED TO CART! Product Name: ${product.name} Quantity: $quantity Price:  ${product.price} ID: ${product.id}");
        totalQuantity = existingItem.quantity! + quantity;
        return CartModal(
          id: existingItem.id,
          name: existingItem.name,
          price: existingItem.price,
          image: existingItem.image,
          quantity: existingItem.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if(totalQuantity<=0){
        _items.remove(product.id!);
      }
    }

    else{
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () {
          print("ADDED TO CART! Product Name: ${product.name} Quantity: $quantity Price:  ${product.price} ID: ${product.id}");
          return CartModal(
            id: product.id,
            name: product.name,
            price: product.price,
            image: product.image,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      }else{
        Get.snackbar("No Item Selected!", "Please select at least 1 item");
      }
    }

    cartRepo.addToCartList(cartItems);


    update();

  }

  bool isExistInCart(ProductModal product) {
    if(_items.containsKey(product.id!)){
      return true;
    }
    else{
      return false;
    }
  }

  int getQuantity(ProductModal product){
    var quantity = 0;
    if(_items.containsKey(product.id!)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
      return quantity;
    }
    else{
      return 0;
    }
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModal> get cartItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount += value.quantity! * value.price!;
    });
    return totalAmount;
  }

  List<CartModal> getCartData(){
    setCart = cartRepo.getCartList();
    return storageCartItems;
  }

  set setCart(List<CartModal> items){
    storageCartItems = items;
    print("LENGTH OF ITEMS IN DB: ${storageCartItems.length}");
    for(int i = 0; storageCartItems.length > i; i++){
      _items.putIfAbsent(storageCartItems[i].product!.id!, () => storageCartItems[i]);
    }
  }

  void addToHistory(){
    // debugPrint("IN CONTROLLER");
    cartRepo.addToCartHistory();
    clear();
  }

  void clear(){
    _items = {};
    _items.clear();
    update();
  }

  List<CartModal> getCartHistoryList(){
    return cartRepo.getHistoryList();
  }

  set setItems(Map<int,CartModal> setItems){
    _items = {};
    _items = setItems;
  }

  void getItems(){
    cartRepo.addToCartList(cartItems);
    update();
  }
}
