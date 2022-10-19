import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/profile/data/models/client_model.dart';
import 'package:tranquil_life/features/auth/domain/repos/auth.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';

class AuthRepoImpl extends AuthRepo<Client, RegisterData> {
  const AuthRepoImpl();

  @override
  Future<Either<ResolvedError, Client>> signIn(
      String email, String password) async {
    try {
      var result = await ApiClient.post(AuthEndPoints.login,
          body: {"email": email, "password": password});
      final List<String>? errors = (result.data['errors'] as List?)?.cast();
      if (errors != null) {
        return Left(ResolvedError(
          message: errors.fold('', (prev, next) => '$prev\n$next').trim(),
        ));
      }
      final userData = result.data['user'];
      if (userData == null) {
        return const Left(ResolvedError(
          message: 'There is no user associated with this email',
          cause: EmailError(),
        ));
      }
      return Right(ClientModel.fromJson(userData));
    } catch (e) {
      return const Left(ResolvedError(
        message: 'There was a problem logging you in. Try again later',
      ));
    }
  }

  @override
  Future<Either<ResolvedError, Client>> register(RegisterData params) async {
    try {
      var result = await ApiClient.post(
        AuthEndPoints.register,
        body: params.toJson(),
      );
      final List<String>? errors = (result.data['errors'] as List?)?.cast();
      if (errors != null) {
        if (errors.length == 1 &&
            errors[0] == 'The email has already been taken.') {
          return Left(
            ResolvedError(message: errors[0], cause: const EmailError()),
          );
        }
        return Left(ResolvedError(
          message: errors.fold('', (prev, next) => '$prev\n$next').trim(),
        ));
      }
      return Right(ClientModel.fromJson(result.data['user']));
    } catch (_) {
      print(_);
      return const Left(ResolvedError(
        message: 'There was a problem creating your account. Tray again later',
      ));
    }
  }

  @override
  Future<Either<ResolvedError, bool>> resetPassword(String email) async {
    try {
      var result = await ApiClient.post(AuthEndPoints.passwordReset,
          body: {'email': email});
      return const Right(true);
    } catch (e) {
      return const Left(ResolvedError(
        message: 'There was am issue sending the email. Tray again later',
      ));
    }
  }
/* 
  @override
  Future<Either<ResolvedError, bool>> isAuthenticated() async {
    try {
      var result = await ApiClient.post(AuthEndPoints.isAuthenticated);
      print(result.data);
      return Right(result.data != null);
    } catch (e, s) {
      print(e);
      print(s);
      return const Left(ResolvedError());
    }
  }

  @override
  Future<Either<ResolvedError, dynamic>> updateData() {
    // TODO: implement updateData
    throw UnimplementedError();
  } */
}
