import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class ShareNotesDialog extends StatefulWidget {
  const ShareNotesDialog(this.notes, {Key? key, required this.consultant})
      : super(key: key);

  final List<Note> notes;
  final Consultant consultant;

  @override
  State<ShareNotesDialog> createState() => _ShareNotesDialogState();
}

class _ShareNotesDialogState extends State<ShareNotesDialog> {
  bool allowUpdates = false;

  @override
  Widget build(BuildContext context) {
    bool isMultiple = widget.notes.length > 1;
    return ConfirmDialog(
      title: 'Share ${isMultiple ? 'These Notes' : 'This Note'}?',
      body: MyDefaultTextStyle(
        style: TextStyle(height: 1.3, color: Colors.grey[700]),
        child: Column(
          children: [
            Text(
                '${widget.consultant.displayName} will get access to ${isMultiple ? 'these notes' : 'this note'}.'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Allow the consultant see the latest update of ${isMultiple ? 'these notes' : 'this note'}',
                  ),
                ),
                const SizedBox(width: 24),
                Switch.adaptive(
                  activeColor: Theme.of(context).primaryColor,
                  value: allowUpdates,
                  onChanged: (val) => setState(() => allowUpdates = val),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      yesDialog: DialogOption(
        'Share',
        onPressed: () {
          Navigator.of(context).pop();
          /*  context.read<JournalBloc>().add(ShareNotes(
                notes: widget.notes,
              )); */
        },
      ),
    );
  }
}
