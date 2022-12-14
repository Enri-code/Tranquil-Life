part of 'consultant_bloc.dart';

class ConsultantState extends BlocStateBase {
  const ConsultantState({
    super.error,
    this.date,
    this.consultantId,
    this.consultants = const [],
    super.status = EventStatus.initial,
  });

  final int? consultantId;
  final DateTime? date;
  final List<Consultant> consultants;

  @override
  ConsultantState copyWith({
    EventStatus? status,
    ApiError? error,
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
