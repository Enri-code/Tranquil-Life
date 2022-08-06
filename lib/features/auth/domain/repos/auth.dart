import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/app/domain/entities/query_params.dart';

abstract class AuthRepo<F extends QueryParams, T> {
  const AuthRepo();

  Future<Either<ResolvedError, T>> register(F params);
  Future<Either<ResolvedError, T>> signIn(String email, String password);
  Future<Either<ResolvedError, dynamic>> resetPassword(String email);
}
