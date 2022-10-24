import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';

abstract class ProfileRepo {
  const ProfileRepo();
  Future<Either<ApiError, Client>> getProfile();
}
