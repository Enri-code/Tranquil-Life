import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';
import 'package:tranquil_life/features/questionnaire/domain/repos/questionnaire_repo.dart';

part 'questionnaire_event.dart';
part 'questionnaire_state.dart';

class QuestionnaireBloc extends Bloc<QuestionnaireEvent, QuestionnaireState> {
  QuestionnaireBloc(this._repo) : super(const QuestionnaireState()) {
    on<Submit>(_submit);
  }

  final QuestionnaireRepo _repo;

  _submit(Submit event, Emitter<QuestionnaireState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var result = await _repo.submit(event.questions);
    result.fold(
      (l) => emit(state.copyWith(status: OperationStatus.error, error: l)),
      (r) => emit(state.copyWith(status: OperationStatus.success)),
    );
  }
}
