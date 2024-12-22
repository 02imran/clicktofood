import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/forgot_password/presentation/bloc/forgot_state.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/gap.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/forgot_bloc.dart';
import '../bloc/forgot_event.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ForgotBloc(),
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
                imagePath: AssetConfig.forgot_pass_page_top_image,
                fit: BoxFit.fill,
              ),
            ),

            // Middle Login Form
            BlocBuilder<ForgotBloc, ForgotState>(
              builder: (context, state) {
                final bloc = context.read<ForgotBloc>();

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Gap(25),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Forgot password?", style: textSize22w600),
                            Text("Don't worry, we will help you to reset it in no time. Provide your Email to to get an OTP code.", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
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
                            errorText: state.forgotEmailError,
                            filled: true,
                            fillColor: ColorConfig.whiteColor,
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) => bloc.add(ForgotEmailChanged(value)),
                        ),

                        const Gap(20),
                        state.isSubmitting
                            ?
                        const Center(child: CircularProgressIndicator())
                            :
                        PrimaryButton(
                          endIcon: AssetConfig.email_icon,
                          btnText: "Send OTP",
                          onPressed: () {
                            bloc.add(ForgotPasswordOtpRequest(context));
                          },
                        ),

                        // state.isSuccess ? const Text("Log in success", style: textSize14w500) : const SizedBox(),

                      ],
                    ),
                  ),
                );
              }
            ),

          ],
        ),
      ),
    );
  }
}
