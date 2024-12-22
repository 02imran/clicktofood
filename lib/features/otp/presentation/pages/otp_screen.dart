import 'dart:async';
import 'package:click_to_food/core/config/color_config.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/core/utils/size_util.dart';
import 'package:click_to_food/core/utils/style_utils.dart';
import 'package:click_to_food/features/otp/presentation/bloc/otp_event.dart';
import 'package:click_to_food/features/otp/presentation/bloc/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/config/asset_config.dart';
import '../../../../core/utils/global_function.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../shared/common_widgets/custom_app_bar.dart';
import '../../../../shared/common_widgets/custom_image_view.dart';
import '../../../../shared/common_widgets/gap.dart';
import '../../../../shared/common_widgets/primary_button.dart';
import '../bloc/otp_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  String emailID = '';
  late int _remainingTime;
  late Key _timerKey;

  @override
  void initState() {
    super.initState();
    _remainingTime = 30;
    _timerKey = UniqueKey(); // Unique key to reset the animation
    getEmailID(context);
  }

  void _restartTimer() {
    setState(() {
      _remainingTime = 30;
      _timerKey = UniqueKey(); // Generate a new key to rebuild the TweenAnimationBuilder
    });
  }

  Future<String> getEmailID(BuildContext context) async {
    var email = await PrefUtils.getEmail();
    setState(() {
      emailID = email;
    });
    debugPrint("EmailID ::: $emailID");
    return emailID;
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => OtpBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConfig.whiteColor,
        appBar: const CustomAppBar(title: ""),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Top
            const Gap(50),
            Align(
              alignment: Alignment.topLeft,
              child: CustomImageView(
                height: getProportionateScreenHeight(150),
                imagePath: AssetConfig.enter_otp_top_icon,
                fit: BoxFit.fill,
              ),
            ),

            // Middle Otp Form
            BlocBuilder<OtpBloc, OtpState>(
              builder: (context, state) {
                final bloc = context.read<OtpBloc>();

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Gap(25),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("OTP verification", style: textSize22w600),
                            const Gap(5),
                            Text("We have sent an OTP to ${maskEmail(emailID)}", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
                            const Gap(15),
                            Text("Please enter the code below:", style: textSize14w500.copyWith(color: ColorConfig.textColorSecondary)),
                          ],
                        ),

                        const Gap(15),
                        SizedBox(
                        width: SizeConfig.screenWidth,
                        child: Pinput(
                          controller: _otpController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          autofocus: true,
                          length: 6,
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onChanged: (pin) => bloc.add(OTPOnChanged(pin)),
                          onCompleted: (pin) => bloc.add(OTPOnChanged(pin)),
                          validator: (s) {
                            return state.otpError;
                          },
                        ),
                      ),

                        const Gap(15),
                        TweenAnimationBuilder<Duration>(
                          key: _timerKey, // Use the unique key to reset the animation
                          duration: Duration(seconds: _remainingTime),
                          tween: Tween(begin: Duration(seconds: _remainingTime), end: Duration.zero),
                          onEnd: () {
                            print('Timer ended');
                          },
                          builder: (BuildContext context, Duration value, Widget? child) {
                            var seconds = value.inSeconds % 60;

                            return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                seconds != 0 ? const SizedBox() : Row(
                                  children: [
                                    Text("Didn't received OTP?", style: textSize12w500.copyWith(color: ColorConfig.textColorSecondary)),
                                    state.isSubmittingResend ? const CircularProgressIndicator() : InkWell(
                                      onTap: () {
                                        _otpController.clear();
                                        bloc.add(const OTPOnChanged(""));
                                        bloc.add(ResendOTP(context));
                                        _restartTimer();
                                      },
                                      child: Text(" Resend OTP", style: textSize13w500.copyWith(color: ColorConfig.primaryColor, fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),

                                Text('Remaining: ${seconds}s',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
                                ),
                              ],
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                );
              }
            ),

            BlocBuilder<OtpBloc, OtpState>(
                builder: (context, state) {
                  final bloc = context.read<OtpBloc>();

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
                          endIcon: AssetConfig.email_icon,
                          btnText: "Submit",
                          onPressed: () {
                            bloc.add(OTPCheck(context));
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
}
