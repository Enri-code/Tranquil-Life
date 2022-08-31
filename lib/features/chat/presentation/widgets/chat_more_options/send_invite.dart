part of 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options.dart';

class _SendInviteDialog extends StatefulWidget {
  const _SendInviteDialog({Key? key}) : super(key: key);

  @override
  State<_SendInviteDialog> createState() => _SendInviteDialogState();
}

class _SendInviteDialogState extends State<_SendInviteDialog> {
  String email = 'test@gmil.com';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ConfirmDialog(
          title: 'Invite Participant',
          body: SizedBox(
            height: 32,
            child: TextField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Email address',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (val) => email = val,
            ),
          ),
          yesDialog: DialogOption(
            'Send Invite',
            autoClose: false,
            onPressed: () {},
          ),
        ),
        if (false) InfoDialog(text: 'Invite successfully sent to $email.'),
      ],
    );
  }
}
