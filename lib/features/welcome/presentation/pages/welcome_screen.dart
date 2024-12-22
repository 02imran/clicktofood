import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/gap.dart';
import '../../../../shared/common_widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorConfig.whiteColor,
        body: Column(
          children: [

            // Top
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomImageView(
                    width: SizeConfig.screenWidth,
                    height: getProportionateScreenHeight(300),
                    imagePath: AssetConfig.welcome_page_top_icon,
                    fit: BoxFit.fill,
                  ),
                ),

                Positioned(
                  bottom: 20,
                  width: SizeConfig.screenWidth,
                  child: Center(child: Text(StringConfig.welcomeBack, style: textSize22w600)),
                ),

              ],
            ),

            // Middle Buttons
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ListView(
                    children: [

                      const Gap(0),
                      Center(child: Text(StringConfig.chooseYourLoginMethod, style: textSize16w500.copyWith(color: ColorConfig.textColorPrimary.withOpacity(0.7)))),

                      const Gap(10),
                      PrimaryButton(
                        endIcon: AssetConfig.email_icon,
                        btnText: StringConfig.continueWithEmail,
                        onPressed: () {
                          context.push(RouterPath.loginScreenPath);
                        },
                      ),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Flexible(child: Container(width: SizeConfig.screenWidth, height: 0.50, color: ColorConfig.textColorSecondary)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("or", style: textSize16w500.copyWith(color: ColorConfig.textColorSecondary)),
                          ),
                          Flexible(child: Container(width: SizeConfig.screenWidth, height: 0.50, color: ColorConfig.textColorSecondary)),

                        ],
                      ),

                      const Gap(10),
                      PrimaryButton(
                        isPrimaryButton: false,
                        startIcon: AssetConfig.google_icon,
                        btnColor: ColorConfig.greyColor,
                        btnTextColor: ColorConfig.textColorPrimary,
                        btnText: StringConfig.continueWithGoogle,
                        onPressed: () {
                          CommonToast.showSuccessToast("Coming Soon..");
                        },
                      ),

                      const Gap(10),
                      PrimaryButton(
                        isPrimaryButton: false,
                        startIcon: AssetConfig.appleIcon,
                        btnColor: ColorConfig.greyColor,
                        btnTextColor: ColorConfig.textColorPrimary,
                        btnText: StringConfig.continueWithApple,
                        onPressed: () {
                          CommonToast.showSuccessToast("Coming Soon..");
                        },
                      ),

                    ],
                  ),
                ),
            ),

            // Bottom T&C
            Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [

                RichText(
                  text: TextSpan(
                      children:[
                        TextSpan(text: "By clicking, you accept our ",  style: textSize12.copyWith(color: ColorConfig.textColorSecondary)),
                        TextSpan(text: 'Terms and Conditions.', style: textSize12.copyWith(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => CommonToast.showSuccessToast("Terms and Conditions. - Coming Soon..")),
                      ],
                  ),
                ),

                const Gap(5),
                RichText(
                  text: TextSpan(
                      children:[
                        TextSpan(text: "Privacy Policy", style: textSize12.copyWith(decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () => CommonToast.showSuccessToast("Privacy Policy - Coming Soon..")),
                        TextSpan(text: " and ",  style: textSize12.copyWith(color: ColorConfig.textColorSecondary)),
                        TextSpan(text: 'Cookies Policy', style: textSize12.copyWith(decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () => CommonToast.showSuccessToast(" Cookies Policy - Coming Soon..")),
                      ],
                  ),
                ),
                const Gap(20),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
