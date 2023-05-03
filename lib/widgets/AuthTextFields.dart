import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';

class AuthTextFields extends StatelessWidget {
  String hintText;
  IconData prefixIcon;
  TextEditingController? controller;
  bool? isObscure;
  AuthTextFields({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.width10+5,right: Dimentions.width10+5,top: Dimentions.height24,bottom: Dimentions.height10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimentions.radius30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure!,
        controller: controller,
        decoration: InputDecoration(
          // hint text,prefix icon, focused border, enabled border, border
          hintText: hintText,
          prefixIcon: Icon(prefixIcon,color: AppColors.yellowColor,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: const BorderSide(color: AppColors.white,width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
            borderSide: const BorderSide(color: AppColors.white,width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimentions.radius30),
          ),

        ),
      ),
    );
  }
}