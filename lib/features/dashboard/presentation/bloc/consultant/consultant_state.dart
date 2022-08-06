part of 'consultant_bloc.dart';
/* 
class ConsultantState extends Equatable {
  const ConsultantState({
    this.error,
    this.consultants = const [],
    this.status = OperationStatus.initial,
  });

  final List<Consultant> consultants;
  final ResolvedError? error;
  final OperationStatus status;

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
  List<Object?> get props => [consultants, status, error];
} */

class ConsultantState extends BlocStateBase {
  const ConsultantState({
    super.error,
    this.consultants = const [],
    super.status = OperationStatus.initial,
  });

  final List<Consultant> consultants;

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
  List<Object?> get props => [...super.props];
}
