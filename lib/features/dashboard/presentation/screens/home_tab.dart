import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_icon_button.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/constants/moods.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/schedule_meeting_screen.dart';
import 'package:tranquil_life/features/dashboard/presentation/widgets/home/meeting_card.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/presentation/screens/questions.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/notifications/presentation/screens/notifications.dart';

part 'package:tranquil_life/features/dashboard/presentation/widgets/home/meetings.dart';
part 'package:tranquil_life/features/dashboard/presentation/widgets/home/meeting_actions_bs.dart';
part 'package:tranquil_life/features/dashboard/presentation/widgets/home/moods_list_widget.dart';
part 'package:tranquil_life/features/dashboard/presentation/widgets/home/title_section.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const _BG(),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const _AppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
                        child: Column(
                          children: [
                            const _Title(),
                            const SizedBox(height: 24),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.425,
                              child: const _Meetings(),
                            ),
                            const SizedBox(height: 32),
                            const _MoodsListView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BG extends StatelessWidget {
  const _BG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.42,
      alignment: Alignment.topCenter,
      child: Container(color: Colors.grey[200]),
    );
  }
}
