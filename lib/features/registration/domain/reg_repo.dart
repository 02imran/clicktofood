import 'package:click_to_food/features/login/data/LoginModel.dart';
import 'package:click_to_food/features/login/data/request/email_body.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/app_logs.dart';
import '../data/request/RegisterBody.dart';

class RegRepo {

  Future<CommonResponse> registerUser(RegisterBody body) async {
    if (kDebugMode) {
      print(UrlUtils.registerUser);
    }

    try{
      Response response = await DioClient().dio.post(UrlUtils.registerUser, data: body.toJson(),
        // options: Options(
        //     headers: {
        //       'Content-Type':'application/json',
        //       'Authorization': '${AppConstantConfig.bearer}$bearerToken',
        //     }
        // ),
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