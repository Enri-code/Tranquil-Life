part of '../screens/chat_screen.dart';

class _MoreOptions extends StatelessWidget {
  const _MoreOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 0, child: Text('Invite participant')),
        const PopupMenuItem(value: 1, child: Text('View participants')),
        const PopupMenuItem(
          value: 2,
          child: Text('Health questionnaire'),
        ),
        const PopupMenuItem(value: 3, child: Text('End session')),
      ],
      onSelected: (int val) {
        //TODO
        switch (val) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            break;
        }
      },
    );
  }
}
