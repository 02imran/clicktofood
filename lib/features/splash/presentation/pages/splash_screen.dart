import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/shared/common_widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      redirect();
    });
    super.initState();
  }

  void redirect() async {
    var refreshToken = await PrefUtils.getRefreshToken();
    if (refreshToken.isEmpty) {
      context.pushReplacement(RouterPath.welcomeScreenPath);
    } else {
      context.pushReplacement(RouterPath.dashboardScreenPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ColorConfig.whiteColor,
      body: Center(
        child: SizedBox(
          height: getProportionateScreenHeight(90),
          child: CustomImageView(imagePath: AssetConfig.appLogo),
        ),
      ),
    );
  }

}
