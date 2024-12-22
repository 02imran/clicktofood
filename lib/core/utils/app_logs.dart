import 'dart:developer';  // Import for logging
import 'package:flutter/foundation.dart';

class AppLogs {
  AppLogs._();

  static String get _getCurrentTime {
    final DateTime now = DateTime.now();
    return "[🕓 ${now.hour}:${now.minute}:${now.second}:${now.millisecond} 🕓";
  }


  static void successLog(String message, [String tag = 'success']) {
    if (kDebugMode) {
      log(
          '[✅✅✅ $tag : $message ✅✅✅]',
          name: 'Success $_getCurrentTime',
          level: 0
      );
    }
  }

  // Debug Log
  static void debugLog(String message, [String tag = 'debug']) {
    if (kDebugMode) {
      log(
          '[🪲🪲🪲 $tag : $message 🪲🪲🪲]',
          name: 'Debug $_getCurrentTime',
          level: 700
      );
    }
  }

  // Info Log
  static void infoLog(String message, [String tag = 'info']) {
    log(
        '[ℹ️ ℹ️ ℹ️  $tag : $message ℹ️ ℹ️ ℹ️]',
        name: 'Info $_getCurrentTime',
        level: 800
    );
  }

  // Error Log
  static void errorLog(String message, [String tag = 'error']) {
    log(
        '[🚫🚫🚫 $tag : $message 🚫🚫🚫]',
        name: 'Error $_getCurrentTime',
        level: 1000  
    );
  }
}
