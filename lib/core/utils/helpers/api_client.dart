import 'package:dio/dio.dart';
import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';

class ApiData {
  final int? statusCode;
  final dynamic data;

  const ApiData(this.data, this.statusCode);
}

abstract class ApiClient {
  static final _client = Dio(
    BaseOptions(baseUrl: baseUrl, connectTimeout: 15000),
  );

  static Options? get _options {
    final token = getIt<IUserDataStore>().token;
    if (token == null) return null;
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  static Future<ApiData> get(String subPath,
      {Map<String, dynamic>? parameters}) {
    return _client
        .get(subPath, queryParameters: parameters, options: _options)
        .then((result) => ApiData(result.data, result.statusCode));
  }

  static Future<ApiData> post(String subPath, {dynamic body}) {
    return _client.post(subPath, data: body, options: _options).then((result) {
      return ApiData(result.data, result.statusCode);
    });
  }
}
