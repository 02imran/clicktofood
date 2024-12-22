import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/config/string_config.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/registration/presentation/bloc/reg_bloc.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/gap.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../../../../shared/dialog/custom_popup.dart';
import '../bloc/reg_event.dart';
import '../bloc/reg_state.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => RegBloc()..add(LoadEmail()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConfig.whiteColor,
        appBar: const CustomAppBar(title: ""),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Personal information", style: textSize22w600),
                  Text("Please provide us your information to continue", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
                ],
              ),
            ),

            // Form
            BlocBuilder<RegBloc, RegState>(
                builder: (context, state) {
                  final bloc = context.read<RegBloc>();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Gap(25),
                          getTextField(context, Icons.person_outline_rounded, "Type your full name", state.nameError, (value) {
                            bloc.add(FullNameChanged(value));
                          }, controller: nameController,
                          ),
                          const Gap(15),
                          getTextField(context, Icons.email_outlined, state.email.isNotEmpty ? state.email : "Type your email", state.emailError, (value) {
                            bloc.add(EmailChanged(value));
                          }, controller: emailController, readOnly: true,
                          ),
                          const Gap(15),
                          getTextField(context, Icons.flag_outlined, "Type your phone number", state.phoneError, (value) {
                            bloc.add(PhoneChanged(value));
                          }, controller: phoneController, keyboardType: TextInputType.number, maxLength: 10,
                          ),
                          const Gap(15),
                          getTextField(context, Icons.lock_outline_rounded, "Type your password", state.passwordError, (value) {
                            bloc.add(PasswordChanged(value));
                          }, controller: passwordController, keyboardType: TextInputType.text, maxLength: 8, bloc: bloc, obscuringCharacter: true,
                          ),
                          const Gap(15),
                          getTextField(context, Icons.lock_outline_rounded, "Confirm your password", state.confirmPasswordError, (value) {
                            bloc.add(ConfirmPasswordChanged(value));
                          }, controller: confirmPasswordController, keyboardType: TextInputType.text, maxLength: 8, bloc: bloc, obscuringCharacter: true,
                          ),

                        ],
                      ),
                    ),
                  );
                }
            ),

            // Bottom
            BlocBuilder<RegBloc, RegState>(
                builder: (context, state) {
                  final bloc = context.read<RegBloc>();

                  return Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Gap(20),
                        state.isSubmitting
                            ?
                        const Center(child: CircularProgressIndicator())
                            :
                        PrimaryButton(
                          btnText: "Register",
                          onPressed: () {
                            bloc.add(UserRegister(context));
                          },
                        ),

                        // state.isSuccess ? const Text("Log in success", style: textSize14w500) : const SizedBox(),
                      ],
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }

  getTextField(BuildContext context, icon, hint, errorText, onChange,
      {TextInputType? keyboardType, int? maxLength, bool? passwordVisibility, TextEditingController? controller, bool? readOnly, RegBloc? bloc, bool? obscuringCharacter}) {
    return BlocBuilder<RegBloc, RegState>(
        builder: (context, state) {
          final bloc = context.read<RegBloc>();

          return TextField(
          controller: controller,
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
            prefixIcon: maxLength == 10
                ?
            SizedBox(width: getProportionateScreenWidth(75),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomImageView(imagePath: AssetConfig.flag_register,),
                  ),
                  Container(height: 40, width: 0.5, color: ColorConfig.greyColor),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("+880", style: textSize14w500,),
                  ),
                ],
              ),
            )
                :
            Icon(icon, size: 25, color: ColorConfig.greyColor),
            suffixIcon: maxLength == 8 ? IconButton(icon: Icon( state.passwordVisibility == true ? Icons.visibility : Icons.visibility_off), onPressed: () {bloc.add(TogglePasswordVisibility());}) : null,
            labelText: hint,
            hintText: hint,
            labelStyle: const TextStyle(color: ColorConfig.textColorSecondary),
            hintStyle: const TextStyle(color: ColorConfig.textColorSecondary),
            floatingLabelStyle: const TextStyle(color: ColorConfig.primaryColor),
            errorStyle: const TextStyle(color: ColorConfig.redColorLite),
            errorText: errorText,
            filled: true,
            fillColor: ColorConfig.whiteColor,
            counterText: "",
          ),
          obscureText: obscuringCharacter == true ? !state.passwordVisibility : false,
          obscuringCharacter: "☻",
          style: const TextStyle(color: ColorConfig.textColorPrimary, fontWeight: FontWeight.bold),
          maxLength: maxLength,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChange,
          readOnly: readOnly ?? false,
        );
      }
    );
  }
}
