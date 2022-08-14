part of 'note_bloc.dart';

class NoteState {
  const NoteState({this.affectedNote});
  final Note? affectedNote;

  NoteState copyWith({Note? affectedNote}) =>
      NoteState(affectedNote: affectedNote ?? this.affectedNote);
}
