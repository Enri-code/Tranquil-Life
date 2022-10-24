import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';

abstract class ItemsRepo<T> {
  const ItemsRepo();

  //Future<Either<ResolvedError, T>> get();
  Future<Either<ApiError, List<T>>> getAll();
}
