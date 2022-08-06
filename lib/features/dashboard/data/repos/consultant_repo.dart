import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/dashboard/domain/entities/consultant.dart';
import 'package:tranquil_life/features/dashboard/domain/repos/consultant_repo.dart';

class ConsultantRepoImpl extends ConsultantRepo {
  @override
  Future<Either<ResolvedError, List<Consultant>>> getAll() async {
    try {
      var result = await ApiClient.get(ConsultantEndPoints.getAll);
      return Right([]);
    } catch (_) {
      return Left(ResolvedError());
    }
  }

/*   @override
  Future<Either<ResolvedError, Consultant>> getProfile(String id) async {
    try {
      var result = await ApiClient.get(ConsultantEndPoints.getProfile);

      return Right(ConsultantModel.fromJson(result.data));
    } catch (_) {
      return Left(ResolvedError());
    }
  } */

  @override
  Future<Either<ResolvedError, dynamic>> rate(String id) async {
    try {
      var result = await ApiClient.get(ConsultantEndPoints.rate);

      return Right(null);
    } catch (_) {
      return Left(ResolvedError());
    }
  }
}
