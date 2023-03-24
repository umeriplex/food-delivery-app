import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modals/cart_modal.dart';
import '../../utils/app_constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModal> cartModalList){
    /*sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY);*/
    cart = [];
    var time = DateTime.now().toString();
    //Converting Objects to String Because SharedPreference Only (Accept/Save/Store) String ::.
    // cartModalList.forEach((element) {
    //  return cart.add(jsonEncode(element));
    // });
    cartModalList.forEach((element){
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModal> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.getStringList(AppConstants.CART_LIST) != null && sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // if (kDebugMode) {
      //   print("INSIDE GET CART LIST : $carts");
      // }
      List<CartModal> cartModalList = [];
      // carts.forEach((element) {
      //   cartModalList.add(CartModal.fromJsom(jsonDecode(element)));
      // });
      carts.forEach((element) => cartModalList.add(CartModal.fromJsom(jsonDecode(element))));
      return cartModalList;
    }
    else{
      return [];
    }
  }

  List<CartModal> getHistoryList(){
   if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
     cartHistory = [];
     cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
   }
   List<CartModal> cartModalList = [];
   cartHistory.forEach((element) => cartModalList.add(CartModal.fromJsom(jsonDecode(element))));
   return cartModalList;
  }

  void addToCartHistory(){

    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    for(int i = 0; i < cart.length; i++){cartHistory.add(cart[i]);}
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);

   debugPrint("History Items Size : ${getHistoryList().length}");
   var count = 1;
   for(int j = 0; j < getHistoryList().length; j++){
     debugPrint("Time Order : ${getHistoryList()[j].time} ${count++}");
   }
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

}