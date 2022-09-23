import 'package:dio/dio.dart';
import 'package:tranquil_life/core/constants/end_points.dart';

class ApiData {
  final int? statusCode;
  final dynamic data;

  const ApiData(this.data, this.statusCode);
}

class ApiClient {
  const ApiClient();

  static final _client =
      Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: 15000));

  static Future<ApiData> get(
    String subPath, {
    Map<String, dynamic>? parameters,
  }) async {
    var result = await _client.get(subPath, queryParameters: parameters);
    return ApiData(result.data, result.statusCode);
  }

  static Future<ApiData> post(String subPath, {dynamic body}) async {
    var result = await _client.post(subPath, data: body);
    return ApiData(result.data, result.statusCode);
  }
}
