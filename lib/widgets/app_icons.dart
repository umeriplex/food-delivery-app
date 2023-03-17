import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/dimentions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final double size;
  final double iconSize;



  AppIcon({Key? key, required this.icon, this.color = const Color(0xff756d54) , this.background = const Color(0xfffcf4e4), this.size=40, this.iconSize =  16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size/2),
      ),
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
    );
  }
}
