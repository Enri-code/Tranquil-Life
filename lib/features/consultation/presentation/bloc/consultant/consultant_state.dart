part of 'consultant_bloc.dart';

class ConsultantState extends BlocStateBase {
  const ConsultantState({
    super.error,
    this.consultants = const [],
    super.status = OperationStatus.initial,
  });

  final List<Consultant> consultants;

  @override
  ConsultantState copyWith({
    OperationStatus? status,
    ResolvedError? error,
    List<Consultant>? consultants,
  }) {
    return ConsultantState(
      consultants: this.consultants..addAll(consultants ?? []),
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [consultants, ...super.props];
}
