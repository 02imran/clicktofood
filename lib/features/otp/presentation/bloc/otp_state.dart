import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String otp;
  final String? otpError;
  final bool isSubmitting;
  final bool isSubmittingResend;
  final bool isSuccess;
  final bool isFailure;

  const OtpState({
    this.otp = '',
    this.otpError,
    this.isSubmitting = false,
    this.isSubmittingResend = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  OtpState copyWith({String? otp, String? otpError, bool? isSubmitting, bool? isSubmittingResend, bool? isSuccess, bool? isFailure}) {
    return OtpState(
      otp: otp ?? this.otp,
      otpError: otpError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmittingResend: isSubmittingResend ?? this.isSubmittingResend,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [otp, otpError, isSubmitting, isSubmittingResend, isSuccess, isFailure];
}
