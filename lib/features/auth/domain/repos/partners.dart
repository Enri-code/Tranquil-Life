import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';

abstract class PartnersRepo {
  const PartnersRepo();
  Future<Either<ApiError, List<Partner>>> getAll();
}
