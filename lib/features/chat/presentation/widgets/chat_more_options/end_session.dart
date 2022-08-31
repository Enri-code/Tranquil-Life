part of 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options.dart';

class _EndSessionDialog extends StatelessWidget {
  const _EndSessionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'End Session?',
      bodyText:
          'Do you want to end your current session with ${context.watch<ChatBloc>().state.consultant!.displayName}?',
      yesDialog: DialogOption(
        'End Session',
        onPressed: () {},
      ),
    );
  }
}
