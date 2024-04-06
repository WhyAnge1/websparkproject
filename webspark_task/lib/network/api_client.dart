import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webspark_task/common/resut.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Result<Response>> get(String url) async {
    Result<Response> result;

    try {
      var response = await _dio.get(url);

      result = Result.fromResult(response);
    } catch (ex) {
      result = Result.fromError(ex);
    }

    return result;
  }

  Future<Result<Response>> post<T>(T body, String url) async {
    Result<Response> result;

    try {
      var response = await _dio.post(url, data: json.encode(body));

      result = Result.fromResult(response);
    } catch (ex) {
      result = Result.fromError(ex);
    }

    return result;
  }

  void dispose() {
    _dio.close(force: true);
  }
}
