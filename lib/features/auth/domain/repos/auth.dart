import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/app/domain/entities/query_params.dart';

abstract class AuthRepo<T, F extends QueryParams> {
  const AuthRepo();

  Future<Either<ApiError, T>> register(F params);
  Future<Either<ApiError, T>> signIn(String email, String password);
  Future<Either<ApiError, dynamic>> resetPassword(String email);
}
