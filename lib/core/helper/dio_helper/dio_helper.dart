import 'package:dio/dio.dart';

class DioHelper {
  static late Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        // baseUrl: 'https://api.trace.moe',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.get(
      url,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> post({
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.post(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> put({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response<dynamic>> delete({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio!.delete(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
