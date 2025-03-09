import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:wingman/core/constants/api_constants.dart';
import 'package:wingman/core/interceptors/auth_interceptor.dart';

final class DioClient {
  late final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            responseType: ResponseType.json,
            //sendTimeout: const Duration(seconds: 10),
            //receiveTimeout: const Duration(seconds: 10),
            // Unauthorized, because we want our RefreshTokenInterceptor onError to be called
            validateStatus: (status) => status != 401,
          ),
        )
        ..interceptors.add(AuthInterceptor())
        ..httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () {
            final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
            client.badCertificateCallback =
                (cert, host, port) => kDebugMode ? true : false; // TODO(serafa.leo): Test this
            return client;
          },
        );

  Future<Response> post(String url, {Object? data}) async {
    return await _dio.post(url, data: data);
  }

  Future<Response> request(String url, {Options? options}) async {
    return await _dio.request(url, options: options);
  }
}
