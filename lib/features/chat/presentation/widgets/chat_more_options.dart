import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/dialogs/rate_consultation_dialog.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/entities/user.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/presentation/screens/questions.dart';

part 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options/view_participant.dart';
part 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options/send_invite.dart';
part 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options/end_session.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 0, child: Text('Invite participant')),
        const PopupMenuItem(value: 1, child: Text('View participants')),
        const PopupMenuItem(value: 2, child: Text('Questionnaire')),
        const PopupMenuItem(value: 3, child: Text('End session')),
      ],
      onSelected: (int val) {
        switch (val) {
          case 0:
            showDialog(
              context: context,
              builder: (_) => const _SendInviteDialog(),
            );
            break;
          case 1:
            showDialog(
              context: context,
              builder: (_) => const _ViewParticipantsDialog(),
            );
            break;
          case 2:
            Navigator.of(context).pushNamed(QuestionsScreen.routeName);
            break;
          case 3:
            showDialog(
              context: context,
              builder: (_) => const _EndSessionDialog(),
            );
            break;
        }
      },
    );
  }
}
