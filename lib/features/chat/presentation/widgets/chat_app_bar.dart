part of '../screens/chat_screen.dart';

class _TitleBar extends StatelessWidget {
  const _TitleBar({Key? key}) : super(key: key);

  final duration = const Duration(minutes: 30);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          const SizedBox(width: 8),
          const BackButtonWhite(),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: UserAvatar(
              size: 44,
              imageUrl:
                  'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.watch<ChatBloc>().state.consultant!.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Text(
                  TimeFormatter.toReadableString(duration.inMilliseconds),
                  style: TextStyle(
                    color: duration.inMinutes > 5
                        ? ColorPalette.yellow
                        : ColorPalette.red[300],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AppBarButton(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(
                TranquilIcons.phone,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                CallScreen.routeName,
                arguments: CallPageData(
                  context.read<ChatBloc>().state.consultant!.id.toString(),
                  false,
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          AppBarButton(
            backgroundColor: Colors.white,
            icon: Icon(
              CupertinoIcons.videocam_fill,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              CallScreen.routeName,
              arguments: CallPageData(
                context.read<ChatBloc>().state.consultant!.id.toString(),
              ),
            ),
          ),
          const MoreOptions(),
        ],
      ),
    );
  }
}
