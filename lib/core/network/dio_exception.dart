import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    //printInfo(info: "DioExceptionsUri -> ${dioError.response?.realUri ?? "No url"}");
    //printInfo(info: "DioExceptionsError -> ${dioError.response?.data ?? "No error"}");

    if (!((dioError.response?.realUri ?? "")
        .toString()
        .contains("https://api.telegram.org/"))) {
      //EventTracker().eventTracker(eventName: "ApiException", pageName: "api", routePath: "${dioError.response?.realUri ?? "No url"}", message: "statusCode: ${dioError.response?.statusCode} exceptionType: ${dioError.type.name} responseData: ${dioError.response?.data}");
    }

    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        // systemMaintenance();
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        // systemMaintenance();
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        // systemMaintenance();
        break;
      case DioExceptionType.connectionError:
        message = "connectionError";
        //InternetConnectivity().showInternetSnackbar();
        // systemMaintenance();
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
      default:
        message = _handleError(dioError.response!.statusCode!, dioError.response!.data);
        break;
    }
  }

  String message = '';

  String _handleError(int statusCode, dynamic errorData) {

    if (errorData is Map<String, dynamic>) {
      if (errorData.containsKey('message')) {
        return errorData['message'] as String;
      }
      return "Something went wrong";
    }else{
      switch (statusCode) {
        case 400:
          return "Bad Request";
        case 401:
          setLogout();
          return "Session Expired Please";
        case 403:
        // setLogout();
          return "Session Expired Please";
        case 404:
          return "Service Not Found";
        case 500:
          // systemMaintenance();
          return 'Internal server error';
        case 502:
          // systemMaintenance();
          return 'An invalid response was received from the upstream server';
        default:
          return 'Something went wrong';
      }
    }
  }
  @override
  String toString() => message;

  setLogout() async {}
}
