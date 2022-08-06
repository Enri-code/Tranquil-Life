part of 'journal_bloc.dart';

class JournalState extends BlocStateBase {
  const JournalState({
    super.error,
    this.notes = const [],
    super.status = OperationStatus.initial,
  });

  final List<Note> notes;

  JournalState copyWith({
    OperationStatus? status,
    ResolvedError? error,
    List<Note>? notes,
  }) {
    return JournalState(
      notes: this.notes..addAll(notes ?? []),
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [...super.props];
}
