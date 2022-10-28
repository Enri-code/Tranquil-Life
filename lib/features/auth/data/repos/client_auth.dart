import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/auth/domain/repos/auth.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/profile/data/models/user_model.dart';
import 'package:tranquil_life/features/profile/domain/entities/user.dart';

class AuthRepoImpl extends AuthRepo<User, RegisterData> {
  const AuthRepoImpl();

  @override
  Future<Either<ApiError, User>> signIn(String email, String password) async {
    try {
      final data = {"email": email, "password": password};

      final result = await ApiClient.post(AuthEndPoints.login, body: data);

      if (result.data['error'] == false) {
        return Right(UserModel.fromJson(result.data['user']));
      }

      final List<String>? errors = (result.data['error'] as List?)?.cast();
      return Left(ApiError(
        message: errors?.fold('', (prev, next) => '$prev\n$next').trim(),
      ));
    } catch (_) {
      return const Left(ApiError(
        message: 'There was a problem logging you in. Try again later',
      ));
    }
  }

  @override
  Future<Either<ApiError, User>> register(RegisterData params) async {
    try {
      final data = params.toJson();

      final result = await ApiClient.post(AuthEndPoints.register, body: data);

      final List<String>? errors = (result.data['errors'] as List?)?.cast();

      if (errors != null) {
        if (errors.length == 1 &&
            errors[0] == 'The email has already been taken.') {
          return Left(
            ApiError(message: errors[0], cause: const EmailError()),
          );
        }

        return Left(ApiError(
          message: errors.fold('', (prev, next) => '$prev\n$next').trim(),
        ));
      }

      return Right(UserModel.fromJson(result.data['user']));
    } catch (_) {
      return const Left(ApiError(
        message: 'There was a problem creating your account. Tray again later',
      ));
    }
  }

  @override
  Future<Either<ApiError, bool>> resetPassword(String email) async {
    throw UnimplementedError();
    /*  try {
      final result = await ApiClient.post(
        AuthEndPoints.passwordReset,
        body: {'email': email},
      );

      return const Right(true);
    } catch (e) {
      return const Left(ApiError(
        message: 'There was am issue sending the email. Tray again later',
      ));
    } */
  }
}
