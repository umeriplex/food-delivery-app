import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/dimentions.dart';

class NoData extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoData({Key? key, required this.text, this.imgPath = "assets/image/empty_cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        Dimentions.height20.ph,
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0175,
            color: Theme.of(context).disabledColor
          ),
        ),
      ],
    );
  }
}
