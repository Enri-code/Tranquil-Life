part of 'consultant_bloc.dart';

class ConsultantState extends BlocStateBase {
  const ConsultantState({
    super.error,
    this.date,
    this.consultantId,
    this.consultants = const [],
    super.status = OperationStatus.initial,
  });

  final int? consultantId;
  final DateTime? date;
  final List<Consultant> consultants;

  @override
  ConsultantState copyWith({
    OperationStatus? status,
    ResolvedError? error,
    int? consultantId,
    DateTime? date,
  }) {
    return ConsultantState(
      consultantId: consultantId ?? this.consultantId,
      date: date ?? this.date,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [consultants, ...super.props];
}
