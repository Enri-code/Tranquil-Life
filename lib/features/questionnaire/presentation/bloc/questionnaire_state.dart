part of 'questionnaire_bloc.dart';

class QuestionnaireState extends BlocStateBase {
  const QuestionnaireState({
    super.error,
    super.status = OperationStatus.initial,
  });

  @override
  QuestionnaireState copyWith({
    OperationStatus? status,
    ApiError? error,
  }) {
    return QuestionnaireState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
