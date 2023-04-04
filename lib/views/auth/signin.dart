import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/views/auth/signup.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/AuthTextFields.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();
  var signUpPngs = [
    "t.png",
    "f.png",
    "g.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            (Dimentions.height45-5).ph,
            // logo
            Center(
              child: CircleAvatar(
                radius: Dimentions.radius30+50,
                backgroundColor: AppColors.white,
                backgroundImage: const AssetImage('assets/image/logo part 1.png'),
              ),
            ),
            // heading
            BigText(text: "Welcome Back",size: Dimentions.font26+10,color: AppColors.black87,),
            SmallText(text: "Sign into your account",size: Dimentions.font20,color: AppColors.black54,),
            (Dimentions.height24+6).ph,
            (Dimentions.height24+6).ph,
            // phone
            AuthTextFields(hintText: "Phone",prefixIcon: Icons.phone_android,controller: phoneController,),
            // password
            AuthTextFields(hintText: "Password",prefixIcon: Icons.password,controller: passController,),
            // signUp button
            (Dimentions.height24+6).ph,
            Container(
              width: Dimentions.screenWidth/2,
              height: Dimentions.screenHeight/13,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimentions.radius30),
              ),
              child: const Center(child: Text("Sign Up",style: TextStyle(color: AppColors.white,fontSize: 20),)),
            ),
            (Dimentions.height10).ph,
            // rich text
            RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: AppColors.black54,fontSize: Dimentions.font16),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap =()=> Get.to(()=>SignUp(),transition: Transition.fade),
                      text: " Create",
                      style: TextStyle(color: AppColors.mainColor,fontSize: Dimentions.font16,fontWeight: FontWeight.bold),
                    ),
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
