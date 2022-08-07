import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/domain/repos/consultant_repo.dart';

part 'consultant_event.dart';
part 'consultant_state.dart';

class ConsultantBloc extends Bloc<ConsultantEvent, ConsultantState> {
  ConsultantBloc(this._repo) : super(const ConsultantState()) {
    on(_getConsultants);
    on(_rateConsultants);
  }
  final ConsultantRepo _repo;

  _getConsultants(GetConsultants event, Emitter<ConsultantState> emit) async {}
  _rateConsultants(RateConsultant event, Emitter<ConsultantState> emit) async {}
}
