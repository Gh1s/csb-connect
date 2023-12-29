import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static final Color greyLight = Color(0xffeeeeee);
  static final Color grey = Colors.grey;
  static final Color greyDark = Color(0xff424242);
  static final Color shadow = Colors.black.withOpacity(0.5);
  static const Color chicago = Color(0xff575756);
  static const Color tradeWind = Color(0xff5aadad);
  static const Color mandy = Color(0xffe65a6b);
  static const Color seaBuckthorn = Color(0xfff6a53a);
  static const Color canary = Color(0xffcef664);
  static const Color limeade = Color(0xff689200);
  static const Color atlantis = Color(0xff9ac331);
  static const Color wasabi = Color(0xff69902d);
  static const Color celeri = Color(0xffb0d05e);
  static const Color brown = Color(0xffcc960e);
}

class ComponentConstants {
  ComponentConstants._();

  static const double shadowBlurRadius = 10.0;
  static const double shadowOffsetX = 3.0;
  static const double shadowOffsetY = 3.0;

  static const double headerPaddingVertical = 25.0;

  static const double footerFontSize = 15.0;

  static const double titleHeight = 60.0;
  static const double titlePadding = 15.0;
  static const double titleIconSize = 50.0;
  static const double titleTextSize = 25.0;
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: ColorConstants.atlantis,
    primaryColorLight: ColorConstants.canary,
    primaryColorDark: ColorConstants.limeade,
  );
}
