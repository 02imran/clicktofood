import 'package:dio/dio.dart';
import 'custom_interseptor.dart';

class DioClient {
  final Dio dio;

  DioClient._internal(this.dio);


  factory DioClient() {
    return DioClient._internal(createDio());
  }


  static Dio createDioWithBaseUrl() {
    return Dio(BaseOptions());
  }


  static Dio createDio() {
    var dio = createDioWithBaseUrl();

    dio.interceptors.add(
      CustomInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 1000,
      ),
    );

    return dio;
  }
}