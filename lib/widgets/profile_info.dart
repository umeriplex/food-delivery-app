import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/texts.dart';

import '../utils/colors.dart';
import 'app_icons.dart';

class ProfileInfo extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  ProfileInfo({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimentions.width20, right: Dimentions.width20,top: Dimentions.height10 + 5,bottom: Dimentions.height10 + 5),
      margin: EdgeInsets.symmetric(horizontal: Dimentions.width10, vertical: Dimentions.height10 - 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimentions.radius15 - 5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: .5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appIcon,
          Dimentions.width20.pw,
          Flexible(
            child: bigText,
          ),

        ],
      ),
    );
  }
}
