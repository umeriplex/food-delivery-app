import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/auth_controller.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("LOADING STATE : ${Get.find<AuthController>().isLoading}");
    return Container(
      height: Dimentions.height20*6,
      width: Dimentions.width20*6,
      padding: EdgeInsets.all(Dimentions.radius20-10),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(Dimentions.radius20*5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 7,
            spreadRadius: 3,// changes position of shadow
          ),
        ],
      ),
      child: const Center(child: CircularProgressIndicator(color: AppColors.white,)),
    );
  }
}
