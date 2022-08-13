part of 'consultant_bloc.dart';

abstract class ConsultantEvent extends Equatable {
  const ConsultantEvent();

  @override
  List<Object> get props => [];
}

class GetConsultants extends ConsultantEvent {
  const GetConsultants();
}

class BookConsultation extends ConsultantEvent {
  const BookConsultation();
}

class RateConsultant extends ConsultantEvent {
  final String id;
  const RateConsultant(this.id);
}
