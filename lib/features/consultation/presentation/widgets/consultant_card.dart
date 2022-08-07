import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/consultant_details.dart';

class ConsultantCard extends StatelessWidget {
  const ConsultantCard({Key? key, required this.consultant}) : super(key: key);

  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    var activeColor = Colors.green; // ?? Colors.grey[300]!;
    return SizedBox(
      height: 164,
      child: Row(
        children: [
          Container(
            width: 132,
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
                    child: Image.network(
                      consultant.avatarUrl,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (_, __, ___) => const Icon(
                        TranquilIcons.profile,
                        color: Colors.grey,
                        size: 120,
                      ),
                      frameBuilder: (_, img, val, ___) {
                        if (val == null) {
                          return const SizedBox.square(
                            dimension: 120,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return img;
                      },
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
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 4),
                Text(
                  consultant.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorPalette.primary[800],
                  ),
                ),
                const Spacer(),
                _Button(
                  label: 'View Profile',
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
                    /*  Navigator.of(context).pushNamed(
                      ConsultantDetailScreen.routeName,
                      arguments: consultant,
                    ); */
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
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPrimary: Colors.black,
          primary: Colors.grey[200],
          shadowColor: Colors.black.withOpacity(0.7),
          surfaceTintColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 14),
            icon,
            const SizedBox(width: 10),
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
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}