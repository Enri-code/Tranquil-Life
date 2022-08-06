part of 'journal_bloc.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class GetNotes extends JournalEvent {
  const GetNotes();
}

class AddNote extends JournalEvent {
  final Note note;
  const AddNote(this.note);
}

class UpdateNote extends JournalEvent {
  final SavedNote note;
  const UpdateNote(this.note);
}
