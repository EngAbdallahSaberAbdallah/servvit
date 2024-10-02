import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../local/cache_helper/cache_keys.dart';
import 'end_points.dart';

class DioHelper {
  static late Dio dio;
  static BuildContext? context;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: false,
      responseHeader: false,
      error: false,
      compact: true,
      maxWidth: 90,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (sendAuthToken) "auth-token": CacheKeysManger.getUserTokenFromCache(),
      "Accept-Language": CacheKeysManger.getLanguageFromCache()
    };
    log(CacheKeysManger.getUserTokenFromCache()!);
    return await dio.get(
      url,
      queryParameters: {"lang": CacheKeysManger.getLanguageFromCache()},
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          checkStatusCode(status!);
          return status < 500;
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (sendAuthToken) "auth-token": CacheKeysManger.getUserTokenFromCache(),
    };
    return await dio.post(
      url,
      queryParameters: {"lang": CacheKeysManger.getLanguageFromCache()},
      data: data,
      options: Options(
        validateStatus: (status) {
          checkStatusCode(status!);
          return status < 500;
        },
      ),
    );
  }

  static Future<Response> postForm({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
  }) async {
    dio.options.headers = {
      "Content-Type": "multipart/form-data",
      if (sendAuthToken) "auth-token": CacheKeysManger.getUserTokenFromCache(),
    };
    return await dio.post(
      url,
      queryParameters: {"lang": CacheKeysManger.getLanguageFromCache()},
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          checkStatusCode(status!);
          return status < 500;
        },
      ),
    );
  }

  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (sendAuthToken) "auth-token": CacheKeysManger.getUserTokenFromCache(),
    };
    return await dio.patch(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          checkStatusCode(status!);
          return status < 500;
        },
      ),
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    bool sendAuthToken = false,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (sendAuthToken) "auth-token": CacheKeysManger.getUserTokenFromCache(),
    };
    return await dio.delete(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          checkStatusCode(status!);
          return status < 500;
        },
      ),
    );
  }

  static checkStatusCode(int status) {
    if (status == 404) {
      toast(text: "Not Found", color: Colors.red);
    } else if (status == 429) {
      toast(text: "Too Many Requests", color: Colors.red);
    } else if (status == 500) {
      toast(text: "Error From Server", color: Colors.red);
    }
  }
}
