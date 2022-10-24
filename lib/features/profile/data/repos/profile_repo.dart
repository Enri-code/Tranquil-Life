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
      final result = await ApiClient.get(ProfileEndPoints.getProfile);
      return Right(ClientModel.fromJson(result.data['user']));
    } catch (e) {
      return const Left(ApiError(
        message: 'There was a problem fetching your info. Try again later',
      ));
    }
  }
}
