import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/forgot_password/presentation/pages/forgot_password_screen.dart';
import '../../features/login/presentation/pages/login_screen.dart';
import '../../features/otp/presentation/pages/otp_screen.dart';
import '../../features/password/presentation/pages/password_screen.dart';
import '../../features/registration/presentation/pages/registration_screen.dart';
import '../../features/set_password/presentation/pages/set_password_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/welcome/presentation/pages/welcome_screen.dart';

// Route paths
String splashScreen = "/splashScreen";
String welcomeScreen = "welcomeScreen";
String loginScreen = "loginScreen";
String otpScreen = "otpScreen";
String registrationScreen = "registrationScreen";
String passwordScreen = "passwordScreen";
String forgotPasswordScreen = "forgotPasswordScreen";
String setPasswordScreen = "setPasswordScreen";
String dashboardScreen = "dashboardScreen";

// GoRouter setup
final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: splashScreen,
  routes: [
    GoRoute(
      path: splashScreen,
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: welcomeScreen,
          builder: (context, state) => const WelcomeScreen(),
          routes: [
            GoRoute(
              path: loginScreen,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: otpScreen,
              builder: (context, state) => const OtpScreen(),
            ),
            GoRoute(
              path: passwordScreen,
              builder: (context, state) => const PasswordScreen(),
            ),
            GoRoute(
              path: registrationScreen,
              builder: (context, state) => const RegistrationScreen(),
            ),
            GoRoute(
              path: forgotPasswordScreen,
              builder: (context, state) => const ForgotPasswordScreen(),
            ),
            GoRoute(
              path: setPasswordScreen,
              builder: (context, state) => const SetPasswordScreen(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: "/$dashboardScreen",
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);

// RouterPath helper class
class RouterPath {
  static var splashRouterPath = splashScreen;
  static var welcomeScreenPath = "$splashScreen/$welcomeScreen";
  static var loginScreenPath = "$welcomeScreenPath/$loginScreen";
  static var otpScreenPath = "$welcomeScreenPath/$otpScreen";
  static var passwordScreenPath = "$welcomeScreenPath/$passwordScreen";
  static var registrationScreenPath = "$welcomeScreenPath/$registrationScreen";
  static var forgotPasswordScreenPath = "$welcomeScreenPath/$forgotPasswordScreen";
  static var setPasswordScreenPath = "$welcomeScreenPath/$setPasswordScreen";

  static var dashboardScreenPath = "/$dashboardScreen";
}

