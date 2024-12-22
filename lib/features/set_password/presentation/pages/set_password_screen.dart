import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/router/app_routes.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/set_password/presentation/bloc/set_pass_bloc.dart';
import 'package:click_to_food/features/set_password/presentation/bloc/set_pass_state.dart';
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
import '../bloc/set_pass_event.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SetPassBloc(),
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
                imagePath: AssetConfig.setup_new_password_top_icon,
                fit: BoxFit.fill,
              ),
            ),

            // Middle Login Form
            BlocBuilder<SetPassBloc, SetPassState>(
              builder: (context, state) {
                final bloc = context.read<SetPassBloc>();

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Gap(25),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Setup new password", style: textSize22w600),
                            Text("Enter a secure key (must be 6 digits)", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
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
                          maxLength: 8,
                          obscureText: !state.passwordVisibility,
                          obscuringCharacter: "☻",
                          keyboardType: TextInputType.text,
                          onChanged: (value) => bloc.add(PassChanged(value)),
                        ),

                        const Gap(15),
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
                            errorText: state.confirmPassError,
                            filled: true,
                            fillColor: ColorConfig.whiteColor,
                          ),
                          maxLength: 8,
                          obscureText: !state.passwordVisibility,
                          obscuringCharacter: "☻",
                          keyboardType: TextInputType.text,
                          onChanged: (value) => bloc.add(ConfirmPassChanged(value)),
                        ),

                      ],
                    ),
                  ),
                );
              }
            ),

            BlocBuilder<SetPassBloc, SetPassState>(
                builder: (context, state) {
                  final bloc = context.read<SetPassBloc>();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Gap(20),
                          state.isSubmitting
                              ?
                          const Center(child: CircularProgressIndicator())
                              :
                          PrimaryButton(
                            endIcon: AssetConfig.email_icon,
                            btnText: "Save and Continue",
                            onPressed: () {
                              bloc.add(SetNewPass(context));
                            },
                          ),

                          // state.isSuccess ? const Text("Log in success", style: textSize14w500) : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
