import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/popular_product_controller.dart';
import 'package:food_odering_app/controllers/recommended_food_controller.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_constants.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/app_icons.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimentions.height45,
            left: Dimentions.width24,
            right: Dimentions.width24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_rounded,
                    color: AppColors.white,
                    background: AppColors.mainColor,
                    iconSize: Dimentions.icon24,
                  ),
                ),
                (Dimentions.height45 + 20).pw,
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                      icon: Icons.home_rounded,
                      color: AppColors.white,
                      background: AppColors.mainColor,
                      iconSize: Dimentions.icon24),
                ),
                AppIcon(
                    icon: Icons.shopping_cart_rounded,
                    color: AppColors.white,
                    background: AppColors.mainColor,
                    iconSize: Dimentions.icon24),
              ],
            ),
          ),
          Positioned(
            top: Dimentions.height24 * 4.5,
            left: Dimentions.width20 + 2,
            right: Dimentions.width20 + 2,
            bottom: 0,
            child: Container(
              width: double.maxFinite,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController) {
                    var _cartList = cartController.cartItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.maxFinite,
                            height: Dimentions.height24 * 4,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex = Get.find<PopularProductController>().popularProductList.indexWhere((element) => element.id == _cartList[index].product!.id);
                                    print("$popularIndex----------P");


                                    var recommendedIndex = Get.find<RecommendedFoodController>().recommendedFoodList.indexWhere((element) => element.id == _cartList[index].product!.id);
                                    print("$recommendedIndex----------R");

                                    if(popularIndex >= 0){
                                      Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cart"));
                                    }else{
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cart"));
                                    }
                                  },
                                  child: Container(
                                    width: Dimentions.width24 * 4,
                                    height: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                                        image: DecorationImage(
                                            image: NetworkImage(AppConstants.imagesUrl + _cartList[index].image.toString() ?? AppConstants.foodPlaceHolder),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Dimentions.height10.pw,
                                Expanded(
                                    child: Container(
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        text: _cartList[index].name.toString(),
                                        color: AppColors.black54,
                                        size: Dimentions.font20,
                                      ),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          BigText(
                                            text: "Price: \$${_cartList[index].product!.price! * _cartList[index].quantity!}",
                                            color: AppColors.priceColor,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  cartController.addItem(_cartList[index].product!,-1);
                                                },
                                                child: AppIcon(
                                                  icon: Icons.remove,
                                                  color: AppColors.mainColor,
                                                  background: Colors.transparent,
                                                  iconSize: Dimentions.icon24,
                                                  size: Dimentions.width24,
                                                ),
                                              ),
                                              Dimentions.width10.pw,
                                              BigText(
                                                text: _cartList[index].quantity.toString() ?? "NA",
                                                color: AppColors.black54,
                                                size: Dimentions.font20,
                                              ),
                                              Dimentions.width10.pw,
                                              InkWell(
                                                onTap: () {
                                                  cartController.addItem(_cartList[index].product!,1);
                                                },
                                                child: AppIcon(
                                                  icon: Icons.add,
                                                  color: AppColors.mainColor,
                                                  background: Colors.transparent,
                                                  iconSize: Dimentions.icon24,
                                                  size: Dimentions.width24,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          );
                        });
                  }
                ),
              ),
            ),
          ),
        ],
      ),



      bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimentions.bottomHeightBar,
              padding: EdgeInsets.only(
                  left: Dimentions.width24,
                  top: Dimentions.height10,
                  right: Dimentions.width24,
                  bottom: Dimentions.height10),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20 * 2),
                  topRight: Radius.circular(Dimentions.radius20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimentions.width24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: "Total: \$${cartController.totalAmount.toString()}"),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // debugPrint("Check Out");
                      cartController.addToHistory();
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimentions.width24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        text: "Check Out",
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
