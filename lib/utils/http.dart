// ignore_for_file: unused_element, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_face/config/http_err.dart';
import 'package:flutter_face/utils/storage.dart';
import 'package:dio/dio.dart';

import 'package:flutter_face/config/index.dart';
import 'package:flutter_face/ui/toast.dart';
import 'package:get/get.dart' as get_x;

enum HttpMethod { get, post }

class Http {
  late Dio _dio;
  static final Http _instance = Http._internal();
  factory Http() => _instance;
  static const num maxRetry = 3;
  static CancelToken cancelToken = CancelToken();
  static const methodValue = {
    HttpMethod.get: 'get',
    HttpMethod.post: 'post',
  };
  Http._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: Config.apiBaseUrl,
      followRedirects: true,
      maxRedirects: 3,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    );
    _dio = Dio(options);
    _dio.interceptors.add(_Interceptor());
    _dio.interceptors.add(_LoggingInterceptor());
  }

  /// 请求
  /// ```
  /// [method] 请求方式
  /// [data] post 请求使用data
  /// [params] get 请求使用params
  /// [showMsg] 是否展示错误提示
  /// ```
  Future<Map<String, dynamic>> request({
    required String url,
    HttpMethod method = HttpMethod.post,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool showMsg = true,
  }) async {
    try {
      Response response = await _dio.request(
        url,
        options: Options(method: methodValue[method]),
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return _disponseResponse(response, showMsg: showMsg);
    } on DioException catch (e) {
      return _disponseCatchDioError(e, showMsg: showMsg);
    }
  }

  /// 处理返回值信息
  static Map<String, dynamic> _disponseResponse(
    Response response, {
    bool showMsg = true,
  }) {
    if (response.statusCode == 200) {
      final data = response.data;
      if (data['code'] != "0") {
        _disponseError(showMsg, data['code'], response: data);
        return HttpError.type(response: data);
      }
      return data;
    }
    _disponseError(showMsg, '_${response.statusCode.toString()}');
    return HttpError.type(response: response.data);
  }

  /// 处理错误信息
  static Map<String, dynamic> _disponseCatchDioError(
    DioException e, {
    bool showMsg = true,
  }) {
    if (e.type == DioExceptionType.cancel ||
        e.type == DioExceptionType.unknown ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      _disponseError(showMsg, _dioErrorTypeCode(e.type));
      return HttpError.type(
        response: {
          'code': _dioErrorTypeCode(e.type),
          'msg': HttpError.codes[_dioErrorTypeCode(e.type)]
        },
      );
    }
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      _disponseError(showMsg, '_${statusCode.toString()}');
      return HttpError.type(
        response: {'code': '$statusCode', 'msg': HttpError.codes[statusCode]},
      );
    }
    _disponseError(showMsg, '99999');
    return HttpError.type(
      response: {'code': '99999', 'msg': HttpError.codes['99999']},
    );
  }

  /// DioErrorType 错误码
  static String _dioErrorTypeCode(type) {
    if (type == DioExceptionType.cancel) {
      return 'cancel';
    }
    if (type == DioExceptionType.unknown) {
      return 'unknown';
    }
    if (type == DioExceptionType.receiveTimeout) {
      return 'receiveTimeout';
    }
    if (type == DioExceptionType.sendTimeout) {
      return 'sendTimeout';
    }
    if (type == DioExceptionType.connectionTimeout) {
      return 'connectTimeout';
    }
    return 'connectionError';
  }

  /// 展示错误信息
  static void _disponseError(
    bool showMsg,
    dynamic errCode, {
    Map? response,
  }) async {
    final codes = HttpError.codes;
    String title = '';
    if (codes[errCode] == null) {
      if (response == null || response['msg'] == null) {
        title = codes['99999']!;
      } else {
        title = response['msg'];
      }
    } else {
      title = response != null && response['msg'] != null
          ? response['msg']
          : codes[errCode];
    }
    if (title.isNotEmpty && showMsg) {
      $toast.showToast(title: title);
    }
    if (errCode == '401' || errCode == '_401') {
      if (get_x.Get.currentRoute != '/login') {
        await Storage().clear();
        get_x.Get.offAllNamed('/login');
      }
    }
  }

  /// 取消请求
  static void cancel() {
    cancelToken.cancel();
  }
}

/// 拦截器
class _Interceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addAll({
      'Authorization': '',
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}

/// 请求日志信息
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("${options.method} 请求接口: ${options.uri.toString()}");
    if (options.method == 'GET') {
      print("请求参数: ${jsonEncode(options.queryParameters)}");
    } else {
      print("请求参数: ${jsonEncode(options.data)}");
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data != null) {
      print("返回数据: ${jsonEncode(response.data)}");
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      print('发生错误: _${err.response?.statusCode}');
    }
    handler.next(err);
  }
}
