import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:click_to_food/core/utils/app_logs.dart';
import 'package:click_to_food/core/utils/global_function.dart';
import 'package:click_to_food/core/utils/pref_utils.dart';
import 'package:click_to_food/features/dashboard/data/request/TokenRefreshBody.dart';
import 'package:click_to_food/shared/common_widgets/common_toast.dart';
import 'package:click_to_food/shared/dialog/custom_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/dash_repo.dart';
import 'dash_event.dart';
import 'dash_state.dart';
import 'dart:async';

class DashBloc extends Bloc<DashEvent, DashState> {
  Timer? _timer;
  late StreamController<int> _timerStreamController;
  late ScrollController scrollController = ScrollController();

  DashBloc() : super(const DashState()) {
    _timerStreamController = StreamController<int>.broadcast();
    on<RefreshToken>(_onRefreshToken);
    on<StartTimer>(_onStartTimer);
    on<StopTimer>(_onStopTimer);
    on<Logout>(_onLogout);
    on<StartScrolling>(_onStartScrolling);
    on<StopScrolling>(_onStopScrolling);
  }

  Stream<int> get timerStream => _timerStreamController.stream;

  void _onStartTimer(StartTimer event, Emitter<DashState> emit) async {
    _timer?.cancel(); // Cancel any existing timer
    final expirationDateString = await PrefUtils.getTokenExpDateTime();
    final token = await PrefUtils.getToken();
    final refreshToken = await PrefUtils.getRefreshToken();
    AppLogs.infoLog("token >> $token");
    AppLogs.infoLog("refreshToken >> $refreshToken");

    if (expirationDateString.isNotEmpty) {
      try {
        final expirationDate = DateTime.parse(expirationDateString);
        final remainingTime = expirationDate.difference(DateTime.now()).inSeconds;
        // debugPrint("remainingTime :: $remainingTime");

        if (remainingTime > 0) {
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            final timeLeft = remainingTime - timer.tick;
            // debugPrint("timeLeft :: $timeLeft");
            if (timeLeft <= 0) {
              timer.cancel();
              add(RefreshToken(event.context));
            } else {
              _timerStreamController.add(timeLeft);
            }
          });
        } else {
          add(RefreshToken(event.context));
        }
      } catch (e) {
        debugPrint("Error parsing expiration date: $e");
      }
    } else {
      debugPrint("Expiration date string is null or empty");
    }
  }

  void _onStopTimer(StopTimer event, Emitter<DashState> emit) {
    _timer?.cancel();
    _timerStreamController.add(0); // Notify UI of timer stop
  }

  void _onRefreshToken(RefreshToken event, Emitter<DashState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      final token = await PrefUtils.getToken();
      final refToken = await PrefUtils.getRefreshToken();
      var body = TokenRefreshBody(token: token, refreshToken: refToken);
      final response = await DashRepo().refreshToken(body);

      if ((response.refreshToken ?? "").isNotEmpty) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        CommonToast.showSuccessToast("Token refreshed successfully");

        decodeJwtToken(response.token ?? "");
        PrefUtils.storeToken(response.token ?? "");
        PrefUtils.storeRefreshToken(response.refreshToken ?? "");
        add(StartTimer(event.context)); // Restart the timer after refresh
      } else {
        CustomPopUp.showErrorDialog(context: event.context, msg: "Token refreshing failed, try again later.");
        emit(state.copyWith(isSubmitting: false, isSuccess: false, isFailure: true));
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "An unexpected error occurred. Please try again.");
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }

  void decodeJwtToken(String token) {
    try {
      // Split the token into its parts
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid JWT structure');
      }

      // Decode the payload (2nd part of the token)
      final payload = parts[1];
      final normalized = base64Url.normalize(payload); // Ensure correct Base64 padding
      final decodedBytes = base64Url.decode(normalized);
      final decodedString = utf8.decode(decodedBytes);

      // Parse the JSON string to a Dart Map
      final payloadMap = json.decode(decodedString) as Map<String, dynamic>;

      print("Decoded Payload:");
      print(payloadMap);

      // Access specific claims
      final uniqueName = payloadMap['unique_name'];
      final exp = payloadMap['exp'];
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      PrefUtils.storeTokenExpDateTime("$expirationDate");

      print("Unique Name: $uniqueName");
      print("Expires At: $expirationDate");
    } catch (e) {
      print("Error decoding JWT: $e");
    }
  }

  void _onLogout(Logout event , Emitter<DashState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    hideKeyboard(event.context);
    try {
      final token = await PrefUtils.getToken();
      final response = await DashRepo().logout(token);

      if (response.status == 200) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
        CommonToast.showSuccessToast(response.message ?? "Logout Success");

        PrefUtils.storeToken("");
        PrefUtils.storeRefreshToken("");
        PrefUtils.storePassword("");
        PrefUtils.storeUserID("");
        PrefUtils.storeEmail(email: "");
        GoRouter.of(event.context).replace(RouterPath.welcomeScreenPath);
        add(StopTimer());
      } else {
        CustomPopUp.showErrorDialog(context: event.context, msg: response.message ?? "Logout failed");
        emit(state.copyWith(isSubmitting: false, isSuccess: false, isFailure: true));
      }
    } catch (e) {
      CustomPopUp.showErrorDialog(context: event.context, msg: "An unexpected error occurred. Please try again.");
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }

  void _onStartScrolling(StartScrolling event, Emitter<DashState> emit) async {
    double targetOffset = 130 * 5; // Scroll 5 items (adjust based on item width)
    scrollController.animateTo(targetOffset, duration: const Duration(seconds: 2), curve: Curves.easeInOut).then((_) {
      // Wait and reset scroll to the start
      Timer(const Duration(seconds: 1), () {
        scrollController.animateTo(0, duration: const Duration(seconds: 2), curve: Curves.easeInOut);
      });
    });
  }

  void _onStopScrolling(StopScrolling event, Emitter<DashState> emit) {
    scrollController.jumpTo(0); // Reset scroll to the start
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timerStreamController.close();
    scrollController.dispose(); // Dispose of the ScrollController when the Bloc is closed
    return super.close();
  }

}
