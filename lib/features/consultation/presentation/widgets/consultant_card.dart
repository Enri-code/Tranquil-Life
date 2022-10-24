import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/consultant_details.dart';
import 'package:tranquil_life/features/consultation/presentation/widgets/meeting_date_sheet.dart';

class ConsultantCard extends StatelessWidget {
  const ConsultantCard({Key? key, required this.consultant}) : super(key: key);

  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var activeColor = Colors.green[400]!; // ?? Colors.grey[300]!;
    return IntrinsicHeight(
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Container(
              width: size.width * 0.32,
              height: 164,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: activeColor, width: 3),
              ),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: '${consultant.id}-img',
                      transitionOnUserGestures: true,
                      child: UserAvatar(
                        imageUrl: consultant.avatarUrl,
                        decoration: const BoxDecoration(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Transform.translate(
                      offset: const Offset(10, 10),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  consultant.displayName,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1,
                    color: ColorPalette.green[800],
                  ),
                ),
                const SizedBox(height: 2),
                Align(
                  alignment: const Alignment(-0.9, 0),
                  child: Text(
                    consultant.specialties,
                    style: const TextStyle(fontSize: 12.5),
                  ),
                ),
                const SizedBox(height: 16),
                _Button(
                  label: 'View profile',
                  icon: Icon(TranquilIcons.tag_user,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ConsultantDetailScreen.routeName,
                      arguments: consultant,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _Button(
                  label: 'Schedule a meeting',
                  icon: Icon(TranquilIcons.calendar_tick,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => MeetingDateSheet(consultant),
                    );
                  },
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[200],
          shadowColor: Colors.black.withOpacity(0.5),
          surfaceTintColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 14),
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
