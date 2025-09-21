import 'dart:io';
import 'package:dio/dio.dart';
import '../Utilconfig/ConstantClassUtil.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String authToken)
      : _dio = Dio(
    BaseOptions(
      baseUrl: ConstantClassUtil.urlLink,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptEncodingHeader: "gzip, br",
        HttpHeaders.connectionHeader: "keep-alive",
      },
    ),
  );

  // GET request
  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    return await _dio.get(path, queryParameters: params);
  }

  // POST request
  Future<Response> postData(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    return await _dio.post(path, data: data, queryParameters: params);
  }
}
