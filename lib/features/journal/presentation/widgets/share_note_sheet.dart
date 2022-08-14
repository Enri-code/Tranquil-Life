import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/confirm_dialog.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class ShareNoteBottomSheet extends StatelessWidget {
  const ShareNoteBottomSheet(this.note, {Key? key}) : super(key: key);
  final Note note;

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
                      (index) => const _ConsultantWidget(
                        Consultant(
                          id: '0',
                          name: 'Dr. David blaine Mckenzie',
                          avatarUrl:
                              'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
                        ),
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
  const _ConsultantWidget(this.consultant, {Key? key}) : super(key: key);
  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      containedInkWell: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: ConfirmDialog(
              title: 'Are you sure?',
              body: '${consultant.name} will get access to this note.',
              yesDialog: DialogOption(
                'Share',
                () {
                  //TODO
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          const Divider(height: 16, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                UserAvatar(imageUrl: consultant.avatarUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    consultant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.primary[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
