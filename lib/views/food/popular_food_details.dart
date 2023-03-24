import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/popular_product_controller.dart';
import 'package:food_odering_app/data/repositories/cart_repo.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/texts.dart';
import '../../widgets/title_rsting_widgte.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetails({Key? key, required this.pageId,required this.page}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(),product);

    if (kDebugMode) {
      print("PAGE ID POPULAR : $pageId");
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimentions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.imagesUrl + product.image ??
                      AppConstants.foodPlaceHolder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Icons Widget
          Positioned(
              top: Dimentions.height45,
              left: Dimentions.width24,
              right: Dimentions.width24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        if(page=="cart"){
                          page = "";
                          Get.toNamed(RouteHelper.getCartView());
                        }else{
                          page = "";
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_new_rounded)),


                  GetBuilder<PopularProductController>(
                      builder: (popularProductController) {
                        return InkWell(
                          onTap: () {
                            if(popularProductController.getTotalItems >= 1){
                            Get.toNamed(RouteHelper.getCartView());
                            }else{
                              Get.snackbar("Empty Cart :(", "Please add some items to cart");
                            }
                          },
                          child: Stack(
                            children: [
                              AppIcon(icon: Icons.shopping_cart_checkout_rounded),
                              popularProductController.getTotalItems >= 1
                                  ?
                              Positioned(
                                  right: 1,
                                  top: 0,
                                  child: AppIcon(icon: Icons.circle, size: 20, color: Colors.transparent,background: AppColors.mainColor,)
                              )
                                  :
                              Container(),

                              Get.find<PopularProductController>().getTotalItems >= 1
                                  ?
                              Positioned(
                                  right: 2,
                                  top: 0,
                                  child: BigText(text: Get.find<PopularProductController>().getTotalItems.toString(), color: AppColors.white,))
                                  :
                              Container(),
                            ],
                          ),
                        );
                      }
                  ),
                ],
              )),
          // Introduction of food
          Positioned(
            left: 0,
            right: 0,
            top: Dimentions.popularFoodImgSize - 20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimentions.width24,
                  top: Dimentions.height10,
                  right: Dimentions.width24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20),
                  topRight: Radius.circular(Dimentions.radius20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleRatingWidget(
                    title: product.name.toString() ?? "Food name",
                  ),
                  Dimentions.height24.ph,
                  BigText(text: "Introduce"),
                  Dimentions.height15.ph,
                  // Expandable Text Widget
                  Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableText(
                            text: product.description.toString() ?? "Food Description",
                  )
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductController) {
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
                      InkWell(
                        onTap: () {
                          popularProductController.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      ((Dimentions.width15) / 2).pw,
                      BigText(text: popularProductController.cartItems.toString()),
                      ((Dimentions.width15) / 2).pw,
                      InkWell(
                        onTap: () {
                          popularProductController.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    popularProductController.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimentions.width24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$${product.price} | Add to cart",
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
