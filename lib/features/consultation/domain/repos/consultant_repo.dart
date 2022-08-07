import 'package:dartz/dartz.dart';
import 'package:tranquil_life/app/domain/repos/object_repo.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

abstract class ConsultantRepo extends ItemsRepo<Consultant> {
  const ConsultantRepo();

  //Future<Either<ResolvedError, T>> getProfile(String id);
  Future<Either<ResolvedError, dynamic>> rate(String consultantId, int rating);
}
