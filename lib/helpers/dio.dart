import 'dart:developer';

import 'package:dio/dio.dart';

class ClientApi {
  late Dio dio;

  ClientApi({required String baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60000),
      receiveTimeout: const Duration(seconds: 90000),
      responseType: ResponseType.plain,
      validateStatus: (int? status) {
        return status != null;
      },
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, hander) {
        return hander.next(response);
      },
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        return handler.next(options);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        log('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
        return handler.next(error);
      },
    ));
    dio.interceptors.addAll([ErrorInterceptor()]);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      throw DioException.badResponse(
        statusCode: status!,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    super.onResponse(response, handler);
  }
}
