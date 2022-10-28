import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';

class DeleteNotesDialog extends StatelessWidget {
  const DeleteNotesDialog({
    Key? key,
    required this.notes,
    this.onNoteDeleted,
  }) : super(key: key);

  final List<SavedNote> notes;
  final Function()? onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    bool isMultiple = (notes.length) > 1;
    return ConfirmDialog(
      title: 'Delete Note${isMultiple ? 's' : ''}?',
      bodyText:
          '${isMultiple ? 'These notes' : 'This note'} will be permanently deleted.',
      yesDialog: DialogOption(
        'Delete',
        onPressed: () {
          context.read<JournalBloc>().add(RemoveNotes(notes));
          onNoteDeleted?.call();
        },
      ),
    );
  }
}
