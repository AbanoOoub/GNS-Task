import 'package:dio/dio.dart';

import 'network_urls.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: NetworkUrl.baseURL,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {"Accept": "application/json"},
      validateStatus: (_) => true,
    ));
  }

  static Future<Response> getData(
      {required String endPoint, String? token}) async {
    token != null
        ? dio.options.headers = {
      'Authorization': 'Bearer $token',
    }
        : '';
    return await dio.get(endPoint);
  }

  static Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
            'Authorization': 'Bearer $token',
          }
        : '';
    return dio.post(endPoint, queryParameters: query, data: data);
  }

  static Future<Response> updateData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
            'Authorization': 'Bearer $token',
          }
        : '';
    return dio.put(endPoint, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
      'Authorization': 'Bearer $token',
    }
        : '';
    return dio.delete(endPoint, queryParameters: query, data: data);
  }

}
