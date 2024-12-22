import 'dart:async';

import 'package:click_to_food/core/config/asset_config.dart';
import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/utils/size_config.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_bloc.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_state.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:click_to_food/shared/common_widgets/custom_image_view.dart';
import 'package:click_to_food/shared/common_widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/drawer_menu.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/dash_event.dart';

class DashboardRecentOrdersList extends StatefulWidget {
  const DashboardRecentOrdersList({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardRecentOrdersList> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        itemCount: 25,
        itemBuilder: (context, index) {

          return Card(
            color: ColorConfig.whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            shadowColor: ColorConfig.primaryColor,
            elevation: 6,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding, top: 10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.workspace_premium, color: Colors.amber, size: 20),
                              Text("Top of the week"),
                            ],
                          ),

                          const Gap(10),
                          const Row(
                            children: [
                              Text("Mac Cheese Pizza", style: textSize18w500),
                            ],
                          ),

                          const Gap(2),
                          Row(
                            children: [
                              Text("Size: 12inch", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Gap(10),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            CommonToast.showSuccessToast("Coming soon..");
                          },
                          child: Container(
                            width: getProportionateScreenWidth(85),
                            height: getProportionateScreenHeight(50),
                            decoration: const BoxDecoration(
                              color: ColorConfig.primaryColor,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
                            ),
                            child: const Icon(Icons.add, color: ColorConfig.whiteColor, size: 20),
                          ),
                        ),

                        const Gap(25, direction: Axis.horizontal),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 15),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text("5.0", style: textSize14w600),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),

                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: ColorConfig.primaryColor.withOpacity(0.06),
                    border: Border.all(
                      color: ColorConfig.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConfig.textColorPrimary.withOpacity(0.06),
                        spreadRadius: 1, // How much the shadow spreads
                        blurRadius: 2, // How blurry the shadow is
                        offset: const Offset(-5, 3), // Position of the shadow (x, y)
                      ),
                    ],
                  ),
                  // child: const Icon(Icons.fastfood, size: 60, color: ColorConfig.whiteColor),
                  child: CustomImageView(imagePath: AssetConfig.appLogo, fit: BoxFit.contain,),
                ),
              ],
            ),
          );
        });
  }

}
