part of 'questionnaire_bloc.dart';

abstract class QuestionnaireEvent extends Equatable {
  const QuestionnaireEvent();

  @override
  List<Object> get props => [];
}

class Submit extends QuestionnaireEvent {
  final List<Question> questions;
  const Submit(this.questions);
}
