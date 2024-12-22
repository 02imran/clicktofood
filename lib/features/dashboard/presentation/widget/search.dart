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

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Search> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kTDefaultRadius),
            borderSide: const BorderSide(color: ColorConfig.greyColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kTDefaultRadius),
            borderSide: const BorderSide(color: ColorConfig.greyColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kTDefaultRadius),
            borderSide: const BorderSide(color: ColorConfig.primaryColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kTDefaultRadius),
            borderSide: const BorderSide(color: ColorConfig.redColorLite, width: 1),
          ),
          prefixIcon: const Icon(Icons.search, size: 25, color: ColorConfig.greyColor),
          labelText: "Search..",
          hintText: "Search..",
          labelStyle: const TextStyle(color: ColorConfig.textColorSecondary),
          hintStyle: const TextStyle(color: ColorConfig.textColorSecondary),
          floatingLabelStyle: const TextStyle(color: ColorConfig.primaryColor),
          errorStyle: const TextStyle(color: ColorConfig.redColorLite),
          filled: true,
          fillColor: ColorConfig.whiteColor,
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
