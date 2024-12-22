import 'dart:async';

import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/utils/size_config.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_bloc.dart';
import 'package:click_to_food/features/dashboard/presentation/bloc/dash_state.dart';
import 'package:click_to_food/shared/common_widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/asset_config.dart';
import '../../../../core/config/string_config.dart';
import '../../../../core/utils/app_logs.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/drawer_menu.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/dash_event.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardProfile> {
  var fullName = "";
  var email = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var fullNameD = await PrefUtils.getFullName();
    var emailD = await PrefUtils.getEmail();
    setState(() {
      fullName = fullNameD;
      email = emailD;
    });
    AppLogs.infoLog("fullName :: $fullName");
    AppLogs.infoLog("email :: $email");
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConfig.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.fastfood_rounded, color: ColorConfig.whiteColor, size: 35,)
          ),

          const Gap(10),
          Text(email, style: textSize14w600.copyWith(color: ColorConfig.primaryColor.withOpacity(0.50))),
          Text("Click to", style: textSize22w600.copyWith(color: ColorConfig.primaryColor.withOpacity(0.50))),
          Text("Food", style: textSize32.copyWith(color: ColorConfig.primaryColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
