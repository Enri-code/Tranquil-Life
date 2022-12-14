part of 'package:tranquil_life/features/dashboard/presentation/screens/home_tab.dart';

class _AppBar extends StatefulWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  State<_AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  final onVerifyRecognizer = TapGestureRecognizer();
  bool verified = false;

  @override
  void initState() {
    onVerifyRecognizer.onTap = () {
      //TODO
    };
    super.initState();
  }

  @override
  void dispose() {
    onVerifyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (context.watch<ProfileBloc>().state.user!.isVerified)
          Container(
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: RichText(
              text: TextSpan(
                text: 'You need to ',
                style: const TextStyle(fontSize: 15.5, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'verify your account.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorPalette.red,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: onVerifyRecognizer,
                  ),
                ],
              ),
            ),
          ),
        const Spacer(),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (_) => [
            const PopupMenuItem(value: 0, child: Text('Our blog')),
          ],
          onSelected: (int val) {
            //TODO
            switch (val) {
              case 0:
                break;
            }
          },
        ),
      ],
    );
  }
}

class _Title extends StatefulWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  State<_Title> createState() => _TitleState();
}

class _TitleState extends State<_Title> {
  int count = 2;

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Hi,',
                style: TextStyle(color: themeColor, fontSize: 22),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconButton(
                  onPressed: () {
                    final user = context.read<ProfileBloc>().state.user!;
                    if (user.hasAnsweredQuestions) {
                      Navigator.of(context)
                          .pushNamed(SpeakWithConsultantScreen.routeName);
                    } else {
                      Navigator.of(context)
                          .pushNamed(QuestionsScreen.routeName)
                          .whenComplete(() => setStatusBarBrightness(true));
                    }
                  },
                  icon: Icon(
                    TranquilIcons.users,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(NotificationScreen.routeName);
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      CustomIconButton(
                        icon: Icon(
                          TranquilIcons.bell,
                          size: 28,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      if (count > 0) CountIndicator(count),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          'Ifeanyi!',
          style: TextStyle(
            color: themeColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
