import 'dart:io';

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  return Platform.isAndroid ? (inputHeight / 812.0) * screenHeight : inputHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  return Platform.isAndroid ? (inputWidth / 375.0) * screenWidth : inputWidth;
}

int getProportionateScreenHeightInt(int inputHeight) {
  int screenHeight = SizeConfig.screenHeight!.toInt();
  // 812 is the layout height that designer use
  return Platform.isAndroid ? ((inputHeight / 812.0) * screenHeight).toInt() : inputHeight.toInt();
}

// Get the proportionate height as per screen size
int getProportionateScreenWidthInt(int inputWidth) {
  int screenWidth = SizeConfig.screenWidth!.toInt();
  // 375 is the layout width that designer use
  return Platform.isAndroid ? ((inputWidth / 375.0) * screenWidth).toInt() : inputWidth.toInt();
}