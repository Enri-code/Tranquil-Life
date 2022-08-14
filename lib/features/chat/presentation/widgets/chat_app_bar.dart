part of '../screens/chat_screen.dart';

class _TitleBar extends StatelessWidget {
  const _TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          const SizedBox(width: 8),
          AppBarButton(
            backgroundColor: Colors.white,
            icon: Padding(
              padding: const EdgeInsets.all(1),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 10),
          const UserAvatar(
            size: 46,
            imageUrl: '',
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Dr.Charles Richard',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '60:00',
                  style: TextStyle(
                    color: ColorPalette.yellow,
                    fontWeight: FontWeight.w700,
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
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          AppBarButton(
            backgroundColor: Colors.white,
            icon: Icon(
              CupertinoIcons.videocam_fill,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          const _MoreOptions(),
        ],
      ),
    );
  }
}
