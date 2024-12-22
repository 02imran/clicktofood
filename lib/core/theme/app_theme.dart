import 'package:flutter/material.dart';
import '../config/color_config.dart';
import '../utils/style_utils.dart';

class AppTheme {
  static var themeData = ThemeData(
    primaryColor: ColorConfig.primaryColor,
    scaffoldBackgroundColor: ColorConfig.appBackgroundColor,
    cardTheme: CardTheme(
      color: ColorConfig.whiteColor,
      surfaceTintColor: ColorConfig.whiteColor,
      elevation: 5,
      shadowColor: ColorConfig.whiteColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: textSize12w500.copyWith(color: ColorConfig.redColor)
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorConfig.primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
