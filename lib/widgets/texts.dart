import 'package:flutter/material.dart';

import '../utils/addresses/font_addresses.dart';
import '../utils/dimentions.dart';

// TODO BIG TEXTS
class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      this.size = 0,
      required this.text,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: FontsAddresses.mediumFont,
        color: color,
        fontSize: size == 0 ? Dimentions.font20 : size,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

// TODO SMALL TEXTS
class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    this.size = 14,
    this.height = 1.2,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: FontsAddresses.regularFont,
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
