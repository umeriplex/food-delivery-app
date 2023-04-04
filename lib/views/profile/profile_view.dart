import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/widgets/app_icons.dart';
import 'package:food_odering_app/widgets/texts.dart';

import '../../utils/dimentions.dart';
import '../../widgets/profile_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: BigText(
          text: 'Profile',
          size: Dimentions.font26,
          color: AppColors.white,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimentions.height24),
        child: Column(
          children: [
            // profile icon
            AppIcon(icon: Icons.person,background: AppColors.mainColor,iconSize: Dimentions.icon24+50,color: AppColors.white,size: Dimentions.height45*3,),
            (Dimentions.height45 - 10).ph,
            // name
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileInfo(
                      appIcon: AppIcon(icon: Icons.person,background: AppColors.mainColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                      bigText: BigText(text: "Umer Iftikhar",size: Dimentions.font20,color: AppColors.black54,),
                    ),
                    // telephone
                    ProfileInfo(
                      appIcon: AppIcon(icon: Icons.phone,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                      bigText: BigText(text: "+923402093883",size: Dimentions.font20,color: AppColors.black54,),
                    ),
                    // address
                    ProfileInfo(
                      appIcon: AppIcon(icon: Icons.maps_home_work_outlined,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                      bigText: BigText(text: "Street #146, Block 16, Gulshan e Iqbal, Karachi.",size: Dimentions.font20,color: AppColors.black54,),
                    ),
                    // email
                    ProfileInfo(
                      appIcon: AppIcon(icon: Icons.email_outlined,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                      bigText: BigText(text: "UmerIftikhar2526@gmail.com",size: Dimentions.font20,color: AppColors.black54,),
                    ),
                    // messages
                    ProfileInfo(
                      appIcon: AppIcon(icon: Icons.chat_outlined,background: AppColors.priceColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                      bigText: BigText(text: "Messages",size: Dimentions.font20,color: AppColors.black54,),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
