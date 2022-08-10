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
          style: TextStyle(fontSize: 16, color: ColorPalette.primary[800]),
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
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
    return AnimatedContainer(
      height: 80,
      clipBehavior: Clip.hardEdge,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? null
            : const [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                  offset: Offset(0, 4),
                )
              ],
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
    );
  }
}
