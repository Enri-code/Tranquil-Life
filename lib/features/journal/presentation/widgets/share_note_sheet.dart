import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/share_note_dialog.dart';

class ShareNotesBottomSheet extends StatelessWidget {
  const ShareNotesBottomSheet(this.notes, {Key? key}) : super(key: key);
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: MyDefaultTextStyle(
          style: const TextStyle(fontSize: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text('Share this note with a consultant'),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      8,
                      (index) => _ConsultantWidget(
                        Consultant(
                          id: index,
                          displayName: 'Dr. David blaine Mckenzie',
                          avatarUrl:
                              'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
                        ),
                        notes: notes,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConsultantWidget extends StatelessWidget {
  const _ConsultantWidget(this.consultant, {required this.notes, Key? key})
      : super(key: key);

  final List<Note> notes;
  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      containedInkWell: true,
      onTap: () => showDialog(
        context: context,
        builder: (_) => ShareNotesDialog(notes, consultant: consultant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            UserAvatar(imageUrl: consultant.avatarUrl),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                consultant.displayName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.green[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
