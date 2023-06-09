import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/recommended_food_controller.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/expandable_text.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../modals/popular_product_response_modal.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/app_icons.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetails({Key? key,required this.pageId,required this.page}) : super(key: key);

  final scrollController = ScrollController();
  ProductModal? product;

  @override
  Widget build(BuildContext context) {
    product = Get.find<RecommendedFoodController>().recommendedFoodList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(),product!);

    if (kDebugMode) {
      print("PAGE ID RECOMMENDED : $pageId");
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 8.0,
            toolbarHeight: Dimentions.height45 + 30,
            title: Row(
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

                    }
                ,child: AppIcon(icon: Icons.arrow_back_ios_new_rounded)),

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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimentions.height24),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimentions.height10, bottom: Dimentions.height10),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                ),
                child: Center(
                    child: BigText(
                  text: product!.name.toString()??"Food Name",
                  size: Dimentions.font26,
                )),
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.imagesUrl+product!.image.toString() ?? AppConstants.foodPlaceHolder,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimentions.width15, right: Dimentions.width15),
                  child: ExpandableText(text: product!.description.toString() ?? "Description",) ,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProductController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Price Section
              Container(
                padding: EdgeInsets.only(
                  left: Dimentions.width20*2.5,
                  top: Dimentions.height10,
                  right: Dimentions.width20*2.5,
                  bottom: Dimentions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        popularProductController.setQuantity(false);
                      },
                        child: AppIcon(icon: Icons.remove, color: AppColors.white,background: AppColors.mainColor,iconSize: Dimentions.icon24,)),
                    BigText(text: "\$${product!.price.toString() ?? "N/A"}.0  X  ${popularProductController.cartItems.toString()}",size: Dimentions.font26,color: AppColors.mainBlackColor,),
                    InkWell(
                      onTap:(){
                        popularProductController.setQuantity(true);
                      },
                        child: AppIcon(icon: Icons.add, color: AppColors.white,background: AppColors.mainColor,iconSize: Dimentions.icon24)),
                  ],
                ),
              ),
              // Add to cart Section
              GestureDetector(
                onTap: (){
                  popularProductController.addItem(product!);
                },
                child: Container(
                  height: Dimentions.bottomHeightBar,
                  padding: EdgeInsets.only(left: Dimentions.width24,top: Dimentions.height10,right: Dimentions.width24,bottom: Dimentions.height10),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimentions.radius20*2),
                      topRight: Radius.circular(Dimentions.radius20*2),
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
                        child: Icon(Icons.favorite_border,color: AppColors.mainColor),
                      ),

                      Container(
                        padding: EdgeInsets.all(Dimentions.width24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(text:"\$${product!.price.toString() ?? "N/A"}.0 | Add to cart",color: AppColors.white,),
                      ),

                    ],
                  ) ,
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
