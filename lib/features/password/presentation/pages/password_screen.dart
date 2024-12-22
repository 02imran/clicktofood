import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/password/presentation/bloc/pass_bloc.dart';
import 'package:click_to_food/features/password/presentation/bloc/pass_state.dart';
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
import '../bloc/pass_event.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => PassBloc(),
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
                imagePath: AssetConfig.enter_pass_top_icon,
                fit: BoxFit.fill,
              ),
            ),

            // Middle pass Form
            BlocBuilder<PassBloc, PassState>(
              builder: (context, state) {
                final bloc = context.read<PassBloc>();

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Gap(25),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Enter your password", style: textSize22w600),
                            Text("Please enter your password to continue", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
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
                            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 25, color: ColorConfig.greyColor),
                            suffixIcon: IconButton(icon: Icon( state.passwordVisibility ? Icons.visibility : Icons.visibility_off), onPressed: () {bloc.add(TogglePasswordVisibility());}),
                            labelText: "Type your password",
                            hintText: "Type your password",
                            counterText: "",
                            labelStyle: const TextStyle(color: ColorConfig.textColorSecondary),
                            hintStyle: const TextStyle(color: ColorConfig.textColorSecondary),
                            floatingLabelStyle: const TextStyle(color: ColorConfig.primaryColor),
                            errorStyle: const TextStyle(color: ColorConfig.redColorLite),
                            errorText: state.passError,
                            filled: true,
                            fillColor: ColorConfig.whiteColor,
                          ),
                          style: const TextStyle(color: ColorConfig.textColorPrimary, fontWeight: FontWeight.bold),
                          maxLength: 8,
                          obscureText: !state.passwordVisibility,
                          obscuringCharacter: "☻",
                          keyboardType: TextInputType.text,
                          onChanged: (value) => bloc.add(PasswordChanged(value)),
                        ),

                        const Gap(35),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.push(RouterPath.forgotPasswordScreenPath);
                                },
                                child: const Text("Forgot Password?", style: textSize14w500),
                              ),
                            ],
                          ),
                        ),

                        const Gap(20),
                        state.isSubmitting
                            ?
                        const Center(child: CircularProgressIndicator())
                            :
                        PrimaryButton(
                          endIcon: AssetConfig.email_icon,
                          btnText: StringConfig.logIn,
                          onPressed: () {
                            bloc.add(LoginSubmitted(context));
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
                        context.pop();
                      },
                        imagePath: AssetConfig.google_round_icon, height: getProportionateScreenHeight(30),
                    ),
                    const Gap(10, direction: Axis.horizontal,),
                    CustomImageView(
                      onTap: () {
                        context.pop();
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
