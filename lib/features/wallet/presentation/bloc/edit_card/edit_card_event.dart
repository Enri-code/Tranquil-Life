part of 'edit_card_bloc.dart';

abstract class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object> get props => [];
}

class SetCardData extends EditCardEvent {
  final CardData? data;
  const SetCardData(this.data);
}
