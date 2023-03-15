import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/widgets/texts.dart';

class TextAndIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final double? size;

  TextAndIcon({Key? key, required this.icon, required this.text, this.iconColor, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: size,
        ),
        5.ph,
        SmallText(text: text)
      ],
    );
  }
}
