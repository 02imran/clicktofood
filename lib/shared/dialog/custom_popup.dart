import 'dart:ui';

import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/asset_config.dart';
import '../../core/config/string_config.dart';
import '../../core/utils/global_function.dart';
import '../../core/utils/size_config.dart';
import '../../core/utils/style_utils.dart';
import '../common_widgets/custom_image_view.dart';
import '../common_widgets/gap.dart';
import '../common_widgets/primary_button.dart';

class CustomPopUp {
  static showSuccessDialog({required BuildContext context,required String msg, Function()? onBtnPress, required String btnText}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return PopScope(
          canPop: true,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Dialog(
              insetPadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              backgroundColor: ColorConfig.transparentWhite,
              child: Column(
                children: [
                  // Align(alignment: Alignment.centerRight,
                  //   child: IconButton(
                  //     onPressed: onPressCross ?? () {
                  //       context.pop();
                  //     },
                  //     icon: const Icon(Icons.close, size: 50, weight: 0.1,color: ColorConfig.whiteColor, opticalSize: 0.1,),
                  //   ),
                  // ),

                  Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Image.asset(AssetConfig.login_success_icon, height: getProportionateScreenHeight(130))),
                      const Gap(15),
                      Center(child: Text(msg, style: textSize14w700.copyWith(color: ColorConfig.whiteColor))),
                    ],
                  )),

                  Column(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: PrimaryButton(
                          btnText: btnText,
                          onPressed: onBtnPress,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showErrorDialog({required BuildContext context,required String msg, String? description, Function()? onCrossTap, bool? showServerErrorIcon, bool? isFullScreen, Color? bgColor, Function()? onOkTapFunction}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 220),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        context.pop();
                      }, icon: const Icon(Icons.close, size: 30, weight: 0.1, color: ColorConfig.textColorSecondary, opticalSize: 0.1,))
                    ],
                  ),
                ),

                Center(
                  child: Container(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(50),
                    decoration: BoxDecoration(color: ColorConfig.redColor.withOpacity(0.15), borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: CustomImageView(imagePath: AssetConfig.cross_icon, color: ColorConfig.primaryColor, height: getProportionateScreenHeight(30)),
                    ),
                  ),
                ),

                const Gap(7),
                Center(child: Text("Oops!!", style: textSize14w700.copyWith(color: ColorConfig.textColorPrimary))),
                const Gap(3.5),
                Center(child: Text("Your Can Not Proceed Further", style: textSize14w700.copyWith(color: ColorConfig.textColorPrimary))),

                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(msg, style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary), textAlign: TextAlign.center,),
                ),

                const Gap(0),
                (description ?? "").isEmpty ? const SizedBox() : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(description ?? "", style: textSize12.copyWith(color: ColorConfig.textColorSecondary), textAlign: TextAlign.center,),
                ),
                const Gap(25),

              ],
            ),
          ),
        );
      },
    );
  }

  static showUserNotFoundDialog({required BuildContext context,required String msg, String? description, onCreateAccountPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 220),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: ColorConfig.whiteColor, borderRadius: BorderRadius.circular(kTDefaultRadius)),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: (){
                            context.pop();
                          }, icon: CustomImageView(imagePath: AssetConfig.user_not_found_icon),
                        ),

                        IconButton(
                          onPressed: (){
                            context.pop();
                          }, icon: const Icon(Icons.close, size: 30, weight: 0.1, color: ColorConfig.textColorSecondary, opticalSize: 0.1,),
                        ),
                      ],
                    ),

                    const Gap(7),
                    Text("Account not found!!", style: textSize14w600.copyWith(color: ColorConfig.textColorPrimary)),
                    const Gap(3.5),
                    Text("It looks like theres no account associated with this email ID, Click continue to open a new account.",
                        style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),

                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: PrimaryButton(
                            isPrimaryButton: false,
                            btnText: "Back",
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                        const Gap(10, direction: Axis.horizontal),
                        Flexible(
                          child: PrimaryButton(
                            endIcon: AssetConfig.email_icon,
                            btnText: "Create Account",
                            onPressed: onCreateAccountPressed,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showLoadingDialog({required BuildContext context, String title = "Processing...",}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0XFFf1f2f3),
          insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 220),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const Gap(20),
                    Text(title)
                  ],
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog({required BuildContext context}) {
    context.pop();
  }

}