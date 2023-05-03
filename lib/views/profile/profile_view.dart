import 'package:flutter/material.dart';
import 'package:food_odering_app/base/custom_snackbar.dart';
import 'package:food_odering_app/controllers/cart_controller.dart';
import 'package:food_odering_app/controllers/location_controller.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/widgets/app_icons.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/dimentions.dart';
import '../../widgets/profile_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(userLoggedIn){
      Get.find<UserController>().getUserInfo();
      debugPrint("USER LOGGED IN");
    }

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
      body: GetBuilder<UserController>(
        builder: (userController) {
          return userLoggedIn
              ?
          (userController.isLoading == false
              ?
          Container(
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
                          bigText: BigText(text: userController.userModal!.name.toString() ?? "Name" ,size: Dimentions.font20,color: AppColors.black54,),
                        ),
                        // telephone
                        ProfileInfo(
                          appIcon: AppIcon(icon: Icons.phone,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                          bigText: BigText(text: userController.userModal!.phone.toString() ?? "Phone",size: Dimentions.font20,color: AppColors.black54,),
                        ),
                        // address
                        GetBuilder<LocationController>(
                          builder: (lController) {
                            if(userLoggedIn && lController.addressList.isEmpty){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(RouteHelper.getAddressView());
                                },
                                child: ProfileInfo(
                                  appIcon: AppIcon(icon: Icons.map_rounded,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                                  bigText: BigText(text: "Please add your address",size: Dimentions.font20,color: AppColors.black54,),
                                ),
                              );
                            }
                            else{
                              return ProfileInfo(
                                appIcon: AppIcon(icon: Icons.maps_home_work_outlined,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                                bigText: BigText(text: "Street #146, Block 16, Gulshan e Iqbal, Karachi.",size: Dimentions.font20,color: AppColors.black54,),
                              );
                            }
                          }
                        ),
                        // email
                        ProfileInfo(
                          appIcon: AppIcon(icon: Icons.email_outlined,background: AppColors.yellowColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                          bigText: BigText(text: userController.userModal!.email.toString() ?? "Email",size: Dimentions.font20,color: AppColors.black54,),
                        ),
                        // messages
                        ProfileInfo(
                          appIcon: AppIcon(icon: Icons.chat_outlined,background: AppColors.priceColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                          bigText: BigText(text: "Messages",size: Dimentions.font20,color: AppColors.black54,),
                        ),

                        InkWell(
                          onTap: (){
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().clearData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.toNamed(RouteHelper.getSignInView());
                            }else{
                              customSB("You are not logged in",isError: true,title: "Already Logged Out");
                            }

                          },
                          child: ProfileInfo(
                            appIcon: AppIcon(icon: Icons.login_rounded,background: AppColors.priceColor,color: AppColors.white,iconSize: Dimentions.icon24+6,size: Dimentions.height24+24,),
                            bigText: BigText(text: "Sign out",size: Dimentions.font20,color: AppColors.black54,),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )
              :
          const Center(child: CustomLoader()))
              :
          Center(child: Container(
            color: AppColors.white,
            width: double.maxFinite,
            child: Column(
              children: [
                Dimentions.height20.ph,
                Dimentions.height20.ph,
                Dimentions.height20.ph,
                Dimentions.height20.ph,
                Image.asset("assets/image/signintocontinue.png",width: Dimentions.width45*7,height: Dimentions.height45*7,),
                Dimentions.height20.ph,
                InkWell(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInView());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: "Please Sign in to continue",size: Dimentions.font26,color: AppColors.black54,),
                      Icon(Icons.double_arrow_rounded,color: AppColors.mainColor,size: Dimentions.icon24,)
                    ],
                  ),
                ),
              ],
            ),
          ),);
        }
      ),
    );
  }
}
