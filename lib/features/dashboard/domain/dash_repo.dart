import 'package:click_to_food/features/dashboard/data/request/TokenRefreshResponse.dart';
import 'package:click_to_food/features/login/data/LoginModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/config/app_constant_config.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/app_logs.dart';
import '../data/request/TokenRefreshBody.dart';

class DashRepo {

  Future<TokenRefreshResponse> refreshToken(TokenRefreshBody body) async {
    if (kDebugMode) {
      print(UrlUtils.refreshToken);
    }

    try{
      Response response = await DioClient().dio.post(UrlUtils.refreshToken, data: body.toJson(),
        // options: Options(
        //     headers: {
        //       'Content-Type':'application/json',
        //       'Authorization': '${AppConstantConfig.bearer}$bearerToken',
        //     }
        // ),
      );
      return TokenRefreshResponse.fromJson(response.data);
    }catch(e){
      var errorMessage = e.toString();
      if (e is DioException) {
        DioException dioError = e;
        if (dioError.response != null) {
          errorMessage = "${dioError.response?.data['message']}";
          // return TokenRefreshResponse(message: errorMessage);
        }
      }

      if (kDebugMode) {
        AppLogs.errorLog(errorMessage);
      }
      return TokenRefreshResponse();
    }
  }

  Future<CommonResponse> logout(String token) async {
    if (kDebugMode) {
      print(UrlUtils.logout);
    }

    try{
      Response response = await DioClient().dio.post(UrlUtils.logout, queryParameters: {"Token" : token},
        options: Options(
            headers: {
              'Content-Type':'application/json',
              'Authorization': '${AppConstantConfig.bearer}$token',
            }
        ),
      );
      return CommonResponse.fromJson(response.data);
    }catch(e){
      var errorMessage = e.toString();
      if (e is DioException) {
        DioException dioError = e;
        if (dioError.response != null) {
          errorMessage = "${dioError.response?.data['message']}";
          return CommonResponse(message: errorMessage);
        }
      }

      if (kDebugMode) {
        AppLogs.errorLog(errorMessage);
      }
      return CommonResponse();
    }
  }

}