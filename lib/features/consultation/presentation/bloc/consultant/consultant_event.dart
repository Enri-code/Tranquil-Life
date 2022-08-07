part of 'consultant_bloc.dart';

abstract class ConsultantEvent extends Equatable {
  const ConsultantEvent();

  @override
  List<Object> get props => [];
}

class GetConsultants extends ConsultantEvent {}

class RateConsultant extends ConsultantEvent {
  final String id;
  const RateConsultant(this.id);
}
