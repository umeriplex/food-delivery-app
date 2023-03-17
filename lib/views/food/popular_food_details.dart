import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/texts.dart';
import '../../widgets/title_rsting_widgte.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/food0.png"),
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
                  InkWell(onTap: (){Get.back();},child: AppIcon(icon: Icons.arrow_back_ios_new_rounded)),
                  AppIcon(icon: Icons.shopping_cart_checkout_rounded),
                ],
              )
          ),
          // Introduction of food
          Positioned(
            left: 0,
            right: 0,
            top: Dimentions.popularFoodImgSize - 20,
            bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimentions.width24,top: Dimentions.height10,right: Dimentions.width24),
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
                    TitleRatingWidget(title: "Cheese Frise with Cocomo",),
                    Dimentions.height24.ph,
                    BigText(text: "Introduce"),
                    Dimentions.height15.ph,
                    // Expandable Text Widget
                    Expanded(child : SingleChildScrollView(child: ExpandableText(text: "This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed wThis tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.ith tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.This tuna noodle casserole uses condensed cream of mushroom soup to flavor a creamy sauce that is mixed with tuna, egg noodles, and peas, topped with a crunchy bread crumb topping, and baked to perfection.",))),

                  ],
                ),
              ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.remove,color: AppColors.signColor,),
                  ((Dimentions.width15)/2).pw,
                  BigText(text: "0"),
                  ((Dimentions.width15)/2).pw,
                  Icon(Icons.add,color: AppColors.signColor,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimentions.width24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: AppColors.mainColor,
              ),
              child: BigText(text:"\$10 | Add to cart",color: AppColors.white,),
            ),

          ],
        ) ,
      ),
    );
  }
}


