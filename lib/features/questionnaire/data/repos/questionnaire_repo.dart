import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/features/questionnaire/domain/repos/questionnaire_repo.dart';

class QuestionnaireRepoImpl extends QuestionnaireRepo {
  const QuestionnaireRepoImpl();
/*   @override
  Future<Either<ResolvedError, bool>> hasSubmitted() async {
    //TODO:
    throw UnimplementedError();
  } */

  @override
  Future<Either<ResolvedError, dynamic>> submit(
    List<Question> questions,
  ) async {
    try {
      var data = questions.map((e) => e.toJson()).toList();
      var result = await ApiClient.post(
        QuestionnaireEndPoints.submit,
        body: data,
      );
      if (result.data is List) return const Right(null);
      throw Exception();
    } catch (_) {
      return const Left(ResolvedError());
    }
  }
}
