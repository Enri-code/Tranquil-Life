part of '../screens/schedule_meeting_screen.dart';

class _CardInfo extends StatelessWidget {
  const _CardInfo({
    Key? key,
    required this.title,
    required this.icon,
    required this.info,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 34),
        const SizedBox(width: 24),
        MyDefaultTextStyle(
          style: TextStyle(fontSize: 16, color: ColorPalette.green[800]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(height: 2),
              Text(
                info,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeWidget extends StatelessWidget {
  const _TimeWidget({Key? key, required this.text, this.isSelected = false})
      : super(key: key);

  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      duration: kThemeAnimationDuration,
      textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      style: NeumorphicStyle(
        intensity: 1,
        depth: isSelected ? 2 : -1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : null),
      ),
    );
  }
}

class _DayTimeWidget extends StatelessWidget {
  const _DayTimeWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var onBgColor = isSelected ? Colors.white : Colors.black;

    return SizedBox(
      height: 80,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: isSelected ? 2 : -2,
          intensity: 1,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkResponse(
            containedInkWell: true,
            highlightShape: BoxShape.rectangle,
            onTap: isSelected ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(icon, color: onBgColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          title,
                          style: TextStyle(color: onBgColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
