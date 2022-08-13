import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/confirm_dialog.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class DeleteNoteDialog extends StatelessWidget {
  final Note note;
  const DeleteNoteDialog({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'Delete Note?',
      body: 'This note will be permanently deleted.',
      yesDialog: DialogOption(
        'Delete',
        () {}, //TODO
      ),
    );
  }
}
