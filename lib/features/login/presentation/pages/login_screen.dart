import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/gap.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConfig.whiteColor,
        appBar: const CustomAppBar(title: ""),
        body: Column(
          children: [

            // Top
            const Gap(50),
            Align(
              alignment: Alignment.topLeft,
              child: CustomImageView(
                height: getProportionateScreenHeight(120),
                imagePath: AssetConfig.login_page_top_thought_icon,
                fit: BoxFit.fill,
              ),
            ),

            // Middle Login Form
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final bloc = context.read<LoginBloc>();

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Gap(25),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Log in with email", style: textSize22w600),
                            Text("Let's login into your Click To Food account", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
                          ],
                        ),

                        const Gap(25),
                        TextField(
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
                            prefixIcon: const Icon(Icons.email_outlined, size: 25, color: ColorConfig.greyColor),
                            labelText: "Enter your email",
                            hintText: "Enter your email",
                            labelStyle: const TextStyle(color: ColorConfig.textColorSecondary),
                            hintStyle: const TextStyle(color: ColorConfig.textColorSecondary),
                            floatingLabelStyle: const TextStyle(color: ColorConfig.primaryColor),
                            errorStyle: const TextStyle(color: ColorConfig.redColorLite),
                            errorText: state.emailError,
                            filled: true,
                            fillColor: ColorConfig.whiteColor,
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) => bloc.add(EmailChanged(value)),
                        ),

                        const Gap(20),
                        state.isSubmitting
                            ?
                        const Center(child: CircularProgressIndicator())
                            :
                        PrimaryButton(
                          endIcon: AssetConfig.email_icon,
                          btnText: StringConfig.continueText,
                          onPressed: () {
                            bloc.add(UserCheckIfExists(context));
                          },
                        ),

                        // state.isSuccess ? const Text("Log in success", style: textSize14w500) : const SizedBox(),

                        const Gap(35),
                        Center(
                          child: InkWell(
                            onTap: () {
                              CommonToast.showSuccessToast("Coming Soon..");
                            },
                            child: const Text("Log in with phone number", style: textSize14w500),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }
            ),

            // Bottom
            Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Sign in with",  style: textSize12w600.copyWith(color: ColorConfig.textColorSecondary)),
                const Gap(5),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageView(
                      onTap: () {
                        context.pop();
                      },
                        imagePath: AssetConfig.google_round_icon, height: getProportionateScreenHeight(30),
                    ),
                    const Gap(10, direction: Axis.horizontal,),
                    CustomImageView(
                      onTap: () {
                        context.pop();
                      },
                      imagePath: AssetConfig.apple_round_icon, height: getProportionateScreenHeight(30),
                    ),
                  ],
                ),
                const Gap(15),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
