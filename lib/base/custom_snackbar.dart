import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../widgets/texts.dart';

void customSB(String message, {bool isError = true, String title = "Error"}){
  Get.snackbar(
    title,
    message,
    titleText: BigText(text: title,color: isError ? AppColors.white : AppColors.black87,),
    messageText: SmallText(text: message,color: isError ? AppColors.white : AppColors.black87,),
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? AppColors.priceColor : AppColors.yellowColor,
    colorText: isError ? AppColors.priceColor : AppColors.black87,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,

    duration: const Duration(seconds: 3),
  );
}