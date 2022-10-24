import 'package:dio/dio.dart';
import 'package:tranquil_life/core/constants/end_points.dart';

class ApiData {
  final int? statusCode;
  final dynamic data;

  const ApiData(this.data, this.statusCode);
}

abstract class ApiClient {
  static final _client = Dio(
    BaseOptions(baseUrl: baseUrl, connectTimeout: 15000),
  );

  static Future<ApiData> get(String subPath,
      {Map<String, dynamic>? parameters}) {
    return _client.get(subPath, queryParameters: parameters).then((result) {
      return ApiData(result.data, result.statusCode);
    });
  }

  static Future<ApiData> post(String subPath, {dynamic body}) {
    return _client.post(subPath, data: body).then((result) {
      return ApiData(result.data, result.statusCode);
    });
  }
}
