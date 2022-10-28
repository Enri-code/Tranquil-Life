import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';
import 'package:tranquil_life/features/auth/domain/repos/partners.dart';

part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  PartnerBloc(this._repo) : super(const PartnerState()) {
    on<GetPartnersEvent>(_getPartners);
  }

  final PartnersRepo _repo;

  _getPartners(GetPartnersEvent event, Emitter<PartnerState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var result = await _repo.getAll();
    result.fold(
      (l) => emit(state.copyWith(status: EventStatus.error, error: l)),
      (r) {
        emit(state.copyWith(
          status: EventStatus.success,
          partners: r,
          error: null,
        ));
      },
    );
  }
}
