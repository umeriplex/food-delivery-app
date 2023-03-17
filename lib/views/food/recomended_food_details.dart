import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/expandable_text.dart';
import 'package:food_odering_app/widgets/texts.dart';

import '../../widgets/app_icons.dart';

class RecommendedFoodDetails extends StatelessWidget {
  RecommendedFoodDetails({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverAppBar(
            elevation: 8.0,
            toolbarHeight: Dimentions.height45 + 30,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios_new_rounded),
                AppIcon(icon: Icons.shopping_cart_checkout_rounded),
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
                  text: "Mexican Biryani",
                  size: Dimentions.font26,
                )),
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food0.png",
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
                  child: ExpandableText(text: "Umer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer Umer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmerUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikharUmer iftikhar",) ,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
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
                AppIcon(icon: Icons.remove, color: AppColors.white,background: AppColors.mainColor,iconSize: Dimentions.icon24,),
                BigText(text: "\$500.00 "+" X "+" 0",size: Dimentions.font26,color: AppColors.mainBlackColor,),
                AppIcon(icon: Icons.add, color: AppColors.white,background: AppColors.mainColor,iconSize: Dimentions.icon24),
              ],
            ),
          ),
          // Add to cart Section
          Container(
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
                  child: BigText(text:"\$10 | Add to cart",color: AppColors.white,),
                ),

              ],
            ) ,
          ),
        ],
      ),
    );
  }
}
