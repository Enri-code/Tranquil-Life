part of 'partner_bloc.dart';

class PartnerState extends BlocStateBase {
  const PartnerState({super.status, super.error, this.partners});
  final List<Partner>? partners;

  @override
  List<Object?> get props => [partners, ...super.props];

  @override
  PartnerState copyWith({
    OperationStatus? status,
    ApiError? error,
    List<Partner>? partners,
  }) {
    return PartnerState(
      error: error ?? this.error,
      status: status ?? this.status,
      partners: partners ?? this.partners,
    );
  }
}
