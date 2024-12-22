import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static  clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static void storeUserID(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('UserID', token);
  }
  static Future<String> getUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('UserID') ?? "";
  }

  static void storeToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }
  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? "";
  }

  static void storeTokenExpDateTime(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('storeTokenExpDateTime', token);
  }
  static Future<String> getTokenExpDateTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('storeTokenExpDateTime') ?? "";
  }

  static void storeRefreshToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('RefreshToken', token);
  }
  static Future<String> getRefreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('RefreshToken') ?? "";
  }


  static void storeEmail({required String email}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('msisdn', email);
  }
  static Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('msisdn') ?? "";
  }


  static void storePassword(String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('password', password);
  }
  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('password') ?? "";
  }


  static void storeFullName(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('fullName', token);
  }
  static Future<String> getFullName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('fullName') ?? "";
  }


}
