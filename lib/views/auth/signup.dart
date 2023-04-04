import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/views/auth/signin.dart';
import 'package:get/get.dart';

import '../../base/custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../modals/request_modals/sign_up.dart';
import '../../widgets/AuthTextFields.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

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
            (Dimentions.height45 - 5).ph,
            // logo
            Center(
              child: CircleAvatar(
                radius: Dimentions.radius30 + 50,
                backgroundColor: AppColors.white,
                backgroundImage:
                    const AssetImage('assets/image/logo part 1.png'),
              ),
            ),
            // email
            AuthTextFields(
              hintText: "Enter",
              prefixIcon: Icons.email_outlined,
              controller: emailController,
            ),
            // password
            AuthTextFields(
              hintText: "Password",
              prefixIcon: Icons.password,
              controller: passController,
            ),
            // name
            AuthTextFields(
              hintText: "Name",
              prefixIcon: Icons.person_2_outlined,
              controller: nameController,
            ),
            // phone
            AuthTextFields(
              hintText: "Phone",
              prefixIcon: Icons.phone_android,
              controller: phoneController,
            ),
            // signUp button
            (Dimentions.height24 + 6).ph,
            InkWell(
              onTap: () async {
                debugPrint("Sign Up 1");
                registration();
              },
              child: Container(
                width: Dimentions.screenWidth / 2,
                height: Dimentions.screenHeight / 13,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                ),
                child: const Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(color: AppColors.white, fontSize: 20),
                )),
              ),
            ),
            (Dimentions.height10).ph,
            // rich text
            RichText(
                text: TextSpan(
              text: "Already have an account?",
              style: TextStyle(
                  color: AppColors.black54, fontSize: Dimentions.font16),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Get.to(() => SignIn(), transition: Transition.fade),
                  text: " Sign In",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimentions.font16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
            RichText(
                text: TextSpan(
              text: "or",
              style: TextStyle(
                  color: AppColors.signColor, fontSize: Dimentions.font16),
            )),
            RichText(
                text: TextSpan(
              text: "Sign up using using any given methods",
              style: TextStyle(
                  color: AppColors.signColor, fontSize: Dimentions.font16 - 3),
            )),
            // social media icons
            (Dimentions.height10).ph,
            Wrap(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimentions.radius30 - 5,
                          backgroundColor: AppColors.white,
                          backgroundImage:
                              AssetImage('assets/image/${signUpPngs[index]}'),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  void registration() {
    debugPrint("Sign Up 2");
    var authController = Get.find<AuthController>();
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passController.text.trim();
    if (name.isEmpty) {
      customSB("Please enter your name", isError: true, title: "Blank Field");
    } else if (!GetUtils.isEmail(email)) {
      customSB("Please enter a valid email",
          isError: true, title: "Invalid Email");
    } else if (phone.isEmpty) {
      customSB("Please enter your phone number",
          isError: true, title: "Blank Field");
    } else if (password.isEmpty) {
      customSB("Please enter your password",
          isError: true, title: "Blank Field");
    } else if (password.length < 6) {
      customSB("Password must be at least 6 characters",
          isError: true, title: "Invalid Password");
    } else {
      debugPrint("Sign Up 3");
      SignUpBody signUpBody = SignUpBody(name: name, email: email, password: password, phone: phone);
      authController.registration(signUpBody).then((value) {
        debugPrint("Sign Up 4");
        if (value.getIsSuccess) {
          debugPrint("Sign Up 5");
          customSB(value.getMessage, isError: false, title: "Registration Successful");
        } else {
          debugPrint("Sign Up 6");
          customSB(value.getMessage, isError: true, title: "Failed to register");
        }
      });
      debugPrint("Sign Up 7");
    }
  }
}
