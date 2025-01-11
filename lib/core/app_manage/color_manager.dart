import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xff005356);
  static const Color secondary = Color(0xffEBD5B4);
  static const Color secondary_2 = Color(0xfff3e6d6);
  static const Color textGray = Color(0xff4F4F67);
  static const Color background = Color(0xffF5F5F9);
  static const Color white = Color(0xffFFFFFF);
  static const Color error = Color(0xffF84711);
  static const Color selectNavBar = Color(0xffFF87B3);
  static const Color nonSelectNavBar = Color(0xff8C8C8C);
  static const Color statusBar = Color(0xffE5E5E5);
  static const Color starYellow = Color(0xffFFE621);

  // static Color labelText = const Color(0xffFFFFFF);
  static Color hintText = const Color(0xff929292);
  static const Color borderText = Color(0xffD4D4D4);

  // static Color borderText = const Color(0xffD4D4D4);

  //  static Color buttonText = const Color(0xffFFFFFF);
  //  static Color button = const Color(0xffFFFFFF);
  //
  static const Color darkGrey = Color(0xff525252);
  static const Color grey = Color(0xff8C8C8C);
  static Color lightGrey = const Color(0xffD4D4D4);
//
//  // new colors
//  static Color darkPrimary = const Color(0xffd17d11);
//  static Color lightPrimary = const Color(0xCCd17d11); // color with 80% opacity
//  static Color grey1 = const Color(0xff707070);
//  static Color grey2 = const Color(0xff797979);
//  static Color white = const Color(0xffFFFFFF);
//  static Color error = const Color(0xffe61f34); // red color
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
