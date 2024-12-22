sealed class UrlUtils {
  static String baseUrl = "https://demo-api.devdata.top/api";

  // Login
  static String checkIfUserExists = "$baseUrl/Administrator/CheckUserExists";
  static String login = "$baseUrl/Administrator/Login";
  static String sendOtpToEmail = "$baseUrl/Administrator/SendOTPToEmail";
  static String checkOtpFromEmail = "$baseUrl/Administrator/CheckOTPFromEmail";
  static String registerUser = "$baseUrl/Administrator/SaveUser";
  static String forgotPassword = "$baseUrl/Administrator/ForgetPassword";
  static String logout = "$baseUrl/Administrator/Logout";
  static String refreshToken = "$baseUrl/Administrator/RefreshToken";

}
