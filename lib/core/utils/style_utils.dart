import 'package:click_to_food/core/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../config/color_config.dart';

const TextStyle headline1 = TextStyle(fontWeight: FontWeight.w600, color: ColorConfig.textColorPrimary, fontSize: kTDefaultTextSize);
const TextStyle headline2 = TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: kTDefaultTextSize);
const TextStyle textSize16 = TextStyle(fontSize: kDefaultPadding);
const TextStyle textSize16Bold = TextStyle(fontSize: kDefaultPadding, fontWeight: FontWeight.w600);
const TextStyle textSize12 = TextStyle(fontSize: 12, color: ColorConfig.textColorPrimary);
const TextStyle textSize12Primary = TextStyle(fontSize: 12, color: ColorConfig.primaryColor);
const TextStyle textSizeDefault = TextStyle( color: ColorConfig.primaryColor);
const TextStyle textSize17White = TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold);
const TextStyle textSize40Black = TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold);
const TextStyle textSize14w700 = TextStyle(color: Colors.black54,fontWeight: FontWeight.w700);
const TextStyle textSize14w300 = TextStyle(color: Colors.black54,fontWeight: FontWeight.w300);
const TextStyle textSize9White = TextStyle(fontWeight: FontWeight.w700, color: ColorConfig.whiteColor, fontSize: 9);
const TextStyle textSize10White = TextStyle(fontWeight: FontWeight.w600, color: ColorConfig.whiteColor, fontSize: 10);
const TextStyle textSize10 = TextStyle( fontSize: 10);
const TextStyle textSize32 = TextStyle(fontSize: 32);
const TextStyle textSize14White = TextStyle(color: ColorConfig.whiteColor, fontWeight: FontWeight.w500);
const TextStyle textSize18w600 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const TextStyle textSize18w800 = TextStyle(fontSize: 18, fontWeight: FontWeight.w800);
const TextStyle textSize24w800 = TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
const TextStyle textSize22w600 = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
const TextStyle textSize18w500 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
const TextStyle textSize12w600 = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);
const TextStyle textSize14w600 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
const TextStyle textSize14w400 = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
const TextStyle textSize14w500 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
const TextStyle textSize16w500 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const TextStyle textSize12w500 = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorConfig.textColorSecondary);
const TextStyle textSize12w500PrimaryTextColor = TextStyle(fontSize: 12, color: ColorConfig.textColorPrimary, fontWeight: FontWeight.w500);
const TextStyle textSize12w500PrimaryColor = TextStyle(fontSize: 12, color: ColorConfig.primaryColor, fontWeight: FontWeight.w600);
const TextStyle textSize13w500 = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorConfig.textColorSecondary);
const TextStyle textSize14Primary = TextStyle(fontWeight: FontWeight.w500, color: ColorConfig.primaryColor);
const TextStyle textColorRed = TextStyle( color: ColorConfig.redColor, fontWeight: FontWeight.w500, fontSize: 12);
const TextStyle textSize12Red = TextStyle( color: ColorConfig.redColor);
const TextStyle textStyle8 = TextStyle(fontSize: 8);

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  ),
);
