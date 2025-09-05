import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_distributor_retailer_app/core/network/api_endpoints.dart';

class ApiClient {
  final Dio dio;
  ApiClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("REQUEST");
          debugPrint("URL: ${options.uri}");
          debugPrint("Method: ${options.method}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("RESPONSE");
          debugPrint("Status Code: ${response.statusCode}");
          debugPrint("Data: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint("ERROR");
          debugPrint("Type: ${error.type}");
          debugPrint("Message: ${error.message}");
          debugPrint("URL: ${error.requestOptions.uri}");
          if (error.response != null) {
            debugPrint("Status Code: ${error.response?.statusCode}");
            debugPrint("Error Data: ${error.response?.data}");
          }
          return handler.next(error);
        },
      ),
    );
  }
}
