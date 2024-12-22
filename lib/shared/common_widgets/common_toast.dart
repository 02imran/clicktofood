import 'package:fluttertoast/fluttertoast.dart';
import '../../core/config/color_config.dart';

class CommonToast {
  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorConfig.greenColor,
      textColor: ColorConfig.whiteColor,
      fontSize: 14.0,
    );
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorConfig.redColor,
      textColor: ColorConfig.whiteColor,
      fontSize: 14.0,
    );
  }
}