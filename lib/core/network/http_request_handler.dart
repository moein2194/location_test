import 'package:dio/dio.dart';
import 'package:location_test/core/global/app_global.dart';

class HttpRequestHanlder {

  static Future<(dynamic data, String? errorMessage)> get(
    String path, {
    Map<String, dynamic>? parameters,
    bool hasApi = true,
  }) async {
    try {
      final options = Options(
        headers: _header(hasApi: hasApi),
      );

      final response = await Dio().get(
        path,
        queryParameters: parameters ?? {},
        options: options,
      );

      return (response.data, null);
    } on DioException catch (error) {
      return (null, error.message!);
    }
  }

  static Future<(dynamic data, String? errorMessage)> post(
    String path, {
    Map<String, dynamic>? parameters,
    FormData? data,
    bool hasApi = true,
  }) async {
    try {
      final options = Options(
        headers: _header(hasApi: hasApi),
      );

      final response = await Dio().post(
        path,
        queryParameters: parameters ?? {},
        data: data,
        options: options,
      );

      return (response.data, null);
    } on DioException catch (error) {
      return (null, error.message!);
    }
  }

  static Future<(dynamic data, String? errorMessage)> put(
    String path, {
    Map<String, dynamic>? parameters,
    FormData? data,
    bool hasApi = true,
  }) async {
    try {
      final options = Options(
        headers: _header(hasApi: hasApi),
      );

      final response = await Dio().put(
        path,
        queryParameters: parameters ?? {},
        data: data,
        options: options,
      );

      return (response.data as Map<String, dynamic>, null);
    } on DioException catch (error) {
      return (null, error.message!);
    }
  }

  static Future<(dynamic data, String? errorMessage)> patch(
    String path, {
    Map<String, dynamic>? parameters,
    bool hasApi = true,
  }) async {
    try {
      final options = Options(
        headers: _header(hasApi: hasApi),
      );

      final response = await Dio().patch(
        path,
        queryParameters: parameters ?? {},
        options: options,
      );

      return (response.data as Map<String, dynamic>, null);
    } on DioException catch (error) {
      return (null, error.message!);
    }
  }

  static Future<(dynamic data, String? errorMessage)> delete(
    String path, {
    Map<String, dynamic>? parameters,
    bool hasApi = true,
  }) async {
    try {
      final options = Options(
        headers: _header(hasApi: hasApi),
      );

      final response = await Dio().delete(
        path,
        queryParameters: parameters ?? {},
        options: options,
      );

      return (response.data as Map<String, dynamic>, null);
    } on DioException catch (error) {
      return (null, error.message!);
    }
  }

  static Map<String, dynamic>? _header(
      {bool hasApi = false, bool hasHeader = true}) {
    if (hasHeader) {
      if (hasApi) {
        return {
          'Authorization': AppGlobal.userToken,
          'Content-Type': 'application/json; charset=UTF-8',
        };
      } else {
        return {
          'Content-Type': 'application/json; charset=UTF-8',
        };
      }
    } else {
      return null;
    }
  }
}
