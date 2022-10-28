import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/profile/data/models/client_model.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  const ProfileRepoImpl();

  @override
  Future<Either<ApiError, Client>> getProfile() async {
    try {
      final result = await ApiClient.get(ProfileEndPoints.get);

      final Map<String, dynamic>? data = result.data['profile'];

      if (data != null) return Right(ClientModel.fromJson(data));

      return const Left(ApiError(
        message: 'There was a problem fetching your info. Try again later',
      ));
    } catch (e) {
      return const Left(ApiError(
        message: 'There was a problem fetching your info. Try again later',
      ));
    }
  }

  @override
  Future<Either<ApiError, Client>> updateProfile(Client user) async {
    try {
      final result = await ApiClient.post(
        ProfileEndPoints.edit,
        body: user.toJson(),
      );

      final Map<String, dynamic>? data = result.data['profile'];

      if (data != null) return Right(ClientModel.fromJson(data));

      return const Left(ApiError(
        message: 'There was a problem updating your info. Try again later',
      ));
    } catch (e) {
      return const Left(ApiError(
        message: 'There was a problem updating your info. Try again later',
      ));
    }
  }
}
