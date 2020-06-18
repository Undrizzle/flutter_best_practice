import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_best_practice/constant/constant.dart';

class DioUtil {
  static DioUtil _instance;

  static DioUtil getInstance() {
    if (_instance == null) {
      _instance = DioUtil();
    }
    return _instance;
  }

  Dio dio = Dio();

  DioUtil() {
    dio.options.baseUrl = Constant.BaseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(requestBody: true));
  }

  Future<void> requestHttp(String url, String method, [FormData params, Function successCallBack, Function errorCallBack]) async {
    Response response;
    
    try {
      if (method == 'get') {
        if (params != null) {
          response = await dio.get(url, queryParameters: Map.fromEntries(params.fields));
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.fields.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = Response(statusCode: 201);
      }
      if (errorCallBack != null) {
        errorCallBack(errorResponse);
      }
    }

    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['status'] != 200) {
      if (errorCallBack != null) {
        errorCallBack(dataMap['msg'].toString());
      } else if (successCallBack != null) {
        successCallBack(dataMap);
      }
    }
  }
}