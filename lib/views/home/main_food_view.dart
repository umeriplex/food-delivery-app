import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/texts.dart';
import 'main_food_view_body.dart';

class MainFoodView extends StatefulWidget {
  const MainFoodView({Key? key}) : super(key: key);

  @override
  State<MainFoodView> createState() => _MainFoodViewState();
}

class _MainFoodViewState extends State<MainFoodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // header
          Container(
            margin: EdgeInsets.only(top: Dimentions.height45, bottom: Dimentions.height15),
            padding: EdgeInsets.only(left: Dimentions.width24,top: Dimentions.height10,right: Dimentions.width24),
            child: Container(
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(text: "PAKISTAN",color: AppColors.mainColor,size: 24,),
                        Row(
                          children: [
                            SmallText(text: "Karachi",color: AppColors.black54,),
                            const Icon(Icons.arrow_drop_down,color: AppColors.black54,),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimentions.width45,
                        height: Dimentions.height45,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimentions.radius15),
                        ),
                        child: Icon(
                          size: Dimentions.icon24,
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          // body
          const Expanded(child: SingleChildScrollView(child: MainFoodViewBody())),
        ],
      ),
    );
  }
}
