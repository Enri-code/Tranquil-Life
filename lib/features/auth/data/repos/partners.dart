import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/auth/data/models/partner_model.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';
import 'package:tranquil_life/features/auth/domain/repos/partners.dart';

class PartnersRepoImpl extends PartnersRepo {
  const PartnersRepoImpl();

  @override
  Future<Either<ResolvedError, List<Partner>>> getAll() async {
    try {
      var result = await ApiClient.get(AuthEndPoints.listPartners);
      if (result.data is List && result.statusCode == 200) {
        var data = (result.data as List).map((e) => PartnerModel.fromJson(e));
        return Right(data.toList());
      }
      return const Left(ResolvedError());
    } catch (_) {
      return const Left(ResolvedError());
    }
  }
}
