part of 'consultant_bloc.dart';

abstract class ConsultantEvent extends Equatable {
  const ConsultantEvent();

  @override
  List<Object> get props => [];
}

class GetConsultants extends ConsultantEvent {
  const GetConsultants();
}

class GetConsultantHours extends ConsultantEvent {
  const GetConsultantHours(this.id, this.date);

  final int id;
  final DateTime date;
}

class BookMeeting extends ConsultantEvent {
  const BookMeeting(this.date);
  final String date;
}

class RateConsultant extends ConsultantEvent {
  final String id;
  const RateConsultant(this.id);
}
