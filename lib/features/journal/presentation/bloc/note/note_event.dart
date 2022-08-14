part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class UpdateNote extends NoteEvent {
  final SavedNote note;

  const UpdateNote(this.note);
}
