import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/widgets/texts.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'icon_and_text.dart';

class TitleRatingWidget extends StatelessWidget {
  final String title;
  TitleRatingWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: title,size: Dimentions.font26,),
        Dimentions.height10.ph,
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => const Icon(Icons.star,color: AppColors.mainColor,size: 15,)),
            ),
            3.pw,
            SmallText(text: "4.5",color: AppColors.black54,),
            10.pw,
            SmallText(text: "205 comments",color: AppColors.black54,),


          ],
        ),
        Dimentions.height15.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextAndIcon(
              size: Dimentions.icon24,
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            TextAndIcon(
              size: Dimentions.icon24,
              icon: Icons.location_on,
              text: "2.4km",
              iconColor: AppColors.mainColor,
            ),
            TextAndIcon(
              size: Dimentions.icon24,
              icon: Icons.access_time_outlined,
              text: "12min",
              iconColor: AppColors.iconColor2,
            ),

          ],
        ),
      ],
    );
  }
}