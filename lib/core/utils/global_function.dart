import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../router/app_routes.dart';
import 'app_logs.dart';

goBackToHome(BuildContext context){
  try{
    bool canPop = context.canPop();
    while(canPop){
      context.pop();
      AppLogs.successLog("pop");
      if(canPop==false) break;
    }
    // context.pushReplacement(RouterPath.dashboardScreenPath);
  } catch(e){
    AppLogs.errorLog("$e");
  }
}

goBackToLogin(BuildContext context){
  try{
    bool canPop = context.canPop();
    while(canPop){
      context.pop();
      AppLogs.successLog("pop");
      if(canPop==false) break;
    }
    context.push(RouterPath.loginScreenPath);
  } catch(e){
    AppLogs.errorLog("$e");
  }
}

showKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.focusInDirection(TraversalDirection.up);
}

hideKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
}

String maskEmail(String email) {
  if (email.isEmpty) return '';

  final emailParts = email.split('@');
  if (emailParts.length != 2) return email; // Invalid email format

  final maskedLocalPart = emailParts[0].replaceRange(2, emailParts[0].length, '*' * (emailParts[0].length - 2));
  return '$maskedLocalPart@${emailParts[1]}';
}