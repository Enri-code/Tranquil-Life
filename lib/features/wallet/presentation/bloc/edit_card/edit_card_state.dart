part of 'edit_card_bloc.dart';

class EditCardState extends BlocStateBase {
  const EditCardState({
    super.status,
    super.error,
    this.data,
  });
  final CardData? data;

  @override
  List<Object?> get props => [data, ...super.props];

  @override
  EditCardState copyWith({
    CardData? data,
    OperationStatus? status,
    ResolvedError? error,
  }) =>
      EditCardState(
        data: data ?? this.data,
        status: status ?? this.status,
        error: error ?? this.error,
      );
}
