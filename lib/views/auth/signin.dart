import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/views/auth/signup.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../modals/request_modals/sign_up.dart';
import '../../routes/route_helper.dart';
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
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return controller.isLoading == true
              ?
          const Center(child: CustomLoader())
              :
          SingleChildScrollView(
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
                 AuthTextFields(hintText: "Phone", prefixIcon: Icons.phone_android, controller: phoneController,),
                // password
                AuthTextFields(hintText: "Password",prefixIcon: Icons.password,controller: passController,isObscure: true,),
                // signUp button
                (Dimentions.height24+6).ph,
                InkWell(
                  onTap: ()=>login(controller),
                  child: Container(
                    width: Dimentions.screenWidth/2,
                    height: Dimentions.screenHeight/13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimentions.radius30),
                    ),
                    child: const Center(child: Text("Sign Up",style: TextStyle(color: AppColors.white,fontSize: 20),)),
                  ),
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
          );
        }
      ),
    );
  }

  void login(AuthController controller) {

    String phone = phoneController.text.trim();
    String password = passController.text.trim();
   if (phone.isEmpty) {
      customSB("Please enter your phone number", isError: true, title: "Blank Field");
    } else if (password.isEmpty) {
      customSB("Please enter your password", isError: true, title: "Blank Field");
    } else if (password.length < 6) {
      customSB("Password must be at least 6 characters", isError: true, title: "Invalid Password");
    } else {
      controller.login(phone, password).then((value) {
      if (value.getIsSuccess) {
        customSB(value.getMessage, isError: false, title: "Logged in Successful");
        Get.toNamed(RouteHelper.getInitial());
      } else {
        customSB(value.getMessage, isError: true, title: "Failed to login");
      }
      });
    }
  }
}
