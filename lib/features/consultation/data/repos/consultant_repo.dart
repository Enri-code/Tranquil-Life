import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/domain/repos/consultant_repo.dart';

//TODO
class ConsultantRepoImpl extends ConsultantRepo {
  const ConsultantRepoImpl();
  @override
  Future<Either<ApiError, List<Consultant>>> getAll() async {
    try {
      var result = await ApiClient.get(ConsultantEndPoints.getAll);
      return const Right([]);
    } catch (e) {
      return const Left(ApiError());
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
  Future<Either<ApiError, dynamic>> rate(
    String consultantId,
    int rating,
  ) async {
    try {
      var body = {"consultant_id": consultantId, "rating": rating};
      var result = await ApiClient.post(ConsultantEndPoints.rate, body: body);
      if (result.data == body) return const Right(null);
      return const Left(ApiError());
    } catch (_) {
      return const Left(ApiError());
    }
  }
}
