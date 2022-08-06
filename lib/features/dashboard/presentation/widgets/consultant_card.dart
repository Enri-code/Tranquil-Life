import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';

class ConsultantCard extends StatelessWidget {
  const ConsultantCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineColor = Colors.green; // ?? Colors.grey[300]!;
    return SizedBox(
      height: 164,
      child: Row(
        children: [
          Container(
            width: 132,
            height: 164,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: outlineColor, width: 3),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.translate(
                    offset: const Offset(10, 10),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: outlineColor,
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
                  'Dr David Blaine Mckenzie',
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorPalette.primary[800],
                  ),
                ),
                const Spacer(),
                _Button(
                  label: 'View Profile',
                  icon: SvgPicture.asset('assets/icons/tag-user.svg'),
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                _Button(
                  label: 'Schedule a meeting',
                  icon: SvgPicture.asset('assets/icons/calendar-tick.svg'),
                  onPressed: () {},
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
        onPressed: () {},
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
