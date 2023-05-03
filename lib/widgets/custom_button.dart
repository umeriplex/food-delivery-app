import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/dimentions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  final Color? textColor;
  final bool? transparentBg;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final IconData? icon;
  const CustomButton({Key? key, this.onPressed, required this.text, this.color, this.textColor, this.transparentBg = false, this.margin, this.width, this.height, this.radius = 5, this.fontSize, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparentBg == true ? Colors.transparent : Theme.of(context).primaryColor,
      minimumSize: Size(width == null ? Dimentions.screenWidth : width! , height != null ? height! : Dimentions.height45+10),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimentions.screenWidth,
        height: height ?? Dimentions.height45+10,
        child: TextButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Padding(padding: EdgeInsets.only(right: Dimentions.width10/2),
                child: Icon(icon,color: transparentBg == true ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
              ) : Container(),
              Text(text??'',style: TextStyle(fontSize: fontSize ?? Dimentions.font16,color: transparentBg == true ? Theme.of(context).primaryColor : Theme.of(context).cardColor ),),
            ],
          ),
        ),
      ),
    );
  }
}
