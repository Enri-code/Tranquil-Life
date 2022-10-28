part of 'journal_bloc.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class GetNotes extends JournalEvent {
  final List<SavedNote>? notes;
  const GetNotes([this.notes]);
}

class AddNote extends JournalEvent {
  final Note note;
  const AddNote(this.note);
}

/* class UpdateNote extends JournalEvent {
  final SavedNote note;
  const UpdateNote(this.note);
} */

class RemoveNotes extends JournalEvent {
  final List<SavedNote> notes;
  const RemoveNotes(this.notes);
}

class ShareNotes extends JournalEvent {
  final Consultant consultant;
  final List<SavedNote> notes;
  const ShareNotes({required this.consultant, required this.notes});
}
