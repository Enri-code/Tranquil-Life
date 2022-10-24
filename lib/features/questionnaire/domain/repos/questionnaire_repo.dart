import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';

abstract class QuestionnaireRepo {
  const QuestionnaireRepo();

  //Future<Either<ResolvedError, bool>> hasSubmitted();
  Future<Either<ApiError, dynamic>> submit(List<Question> questions);
}
