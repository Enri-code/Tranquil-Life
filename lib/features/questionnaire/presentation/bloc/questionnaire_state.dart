part of 'questionnaire_bloc.dart';

class QuestionnaireState extends BlocStateBase {
  const QuestionnaireState({
    super.error,
    super.status = EventStatus.initial,
  });

  @override
  QuestionnaireState copyWith({
    EventStatus? status,
    ApiError? error,
  }) {
    return QuestionnaireState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
