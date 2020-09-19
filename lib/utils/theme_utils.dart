import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeUtils {
  static ThemeData get darkTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        accentColor: Colors.white,
        cursorColor: Colors.white,
        toggleableActiveColor: Colors.white,
      );

  static ThemeData get lightTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        accentColor: Colors.black,
        cursorColor: Colors.black,
        toggleableActiveColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      );

  static SystemUiOverlayStyle getStatusNavBarTheme(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarDividerColor:
          Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
      statusBarBrightness: Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
