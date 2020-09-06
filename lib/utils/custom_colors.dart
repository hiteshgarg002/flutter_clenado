import 'package:flutter/material.dart';

class CustomColors {
  static const String red1 = "#E00000";
  static const String red2 = "#D60000";
  static const String red3 = "#DC4E41";
  static const String red4 = "#EB0000";
  static const String red5 = "#C70000";
  static const String red6 = "#E60000";

  static const String grey1 = "#F5F5F5";
  static const String grey2 = "#6B6B6B";
  static const String grey3 = "#696969";
  static const String grey4 = "#666666";
  static const String grey5 = "#E6E6E6";
  static const String grey6 = "#A1A1A1";
  static const String grey7 = "#E8E8E8";
  static const String grey8 = "#919191";
  static const String grey9 = "#C9C9C9";
  static const String grey10 = "#878787";
  static const String grey11 = "#858585";
  static const String grey12 = "#EDEDED";
  static const String grey13 = "#F2F2F2";
  static const String grey14 = "#999999";
  static const String grey15 = "#757575";
  static const String grey16 = "#969696";

  static const String green1 = "#04EB00";

  static const String blue1 = "#0047C2";
}

class ColorToMaterial {
  Color _color;
  int red, green, blue, alpha;

  ColorToMaterial(Color color) {
    this._color = color;
    this.alpha = color.alpha;
    this.red = color.red;
    this.blue = color.blue;
    this.green = color.green;
  }

  factory ColorToMaterial.fromHEX(String hex) {
    int hexColor = int.parse('0xFF$hex');
    return ColorToMaterial(Color(hexColor));
  }

  MaterialColor getMaterialColor() {
    Map<int, Color> map = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };
    MaterialColor material = MaterialColor(this.color.value, map);
    return material;
  }

  Color get color {
    return _color;
  }
}
