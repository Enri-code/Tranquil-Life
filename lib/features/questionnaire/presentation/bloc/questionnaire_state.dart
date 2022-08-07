part of 'questionnaire_bloc.dart';

class QuestionnaireState extends BlocStateBase {
  const QuestionnaireState({
    super.error,
    super.status = OperationStatus.initial,
  });

  @override
  copyWith({
    OperationStatus? status,
    ResolvedError? error,
  }) {
    return QuestionnaireState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
