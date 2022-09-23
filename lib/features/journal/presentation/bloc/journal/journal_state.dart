part of 'journal_bloc.dart';

class JournalState extends BlocStateBase {
  const JournalState({
    super.error,
    this.notes = const [],
    super.status = OperationStatus.initial,
  });

  final List<SavedNote> notes;

  @override
  JournalState copyWith({
    OperationStatus? status,
    ResolvedError? error,
    List<SavedNote>? notes,
  }) {
    return JournalState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [notes, ...super.props];
}
