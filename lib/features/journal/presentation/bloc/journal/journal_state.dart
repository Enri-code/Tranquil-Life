part of 'journal_bloc.dart';

class JournalState extends BlocStateBase {
  const JournalState({
    super.error,
    this.notes = const [],
    super.status = EventStatus.initial,
  });

  final List<SavedNote> notes;

  @override
  JournalState copyWith({
    EventStatus? status,
    ApiError? error,
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
