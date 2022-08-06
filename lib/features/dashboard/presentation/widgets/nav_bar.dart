import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.onPageChanged}) : super(key: key);
  final bool Function(int page) onPageChanged;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  void _onTap(int index) {
    if (widget.onPageChanged(index)) setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Item(
                    label: 'Home',
                    icon: TranquilIcons.home,
                    isSelected: currentIndex == 0,
                    onTap: () => _onTap(0),
                  ),
                  _Item(
                    label: 'Wallet',
                    icon: TranquilIcons.wallet,
                    isSelected: currentIndex == 1,
                    onTap: () => _onTap(1),
                  ),
                  const SizedBox(width: 32),
                  _Item(
                    label: 'Notes',
                    icon: TranquilIcons.book_saved,
                    isSelected: currentIndex == 3,
                    onTap: () => _onTap(3),
                  ),
                  _Item(
                    label: 'Profile',
                    icon: TranquilIcons.profile,
                    isSelected: currentIndex == 4,
                    onTap: () => _onTap(4),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -24),
          child: SafeArea(
            top: false,
            child: GestureDetector(
              onTap: () => widget.onPageChanged(2),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(width: 8, color: Colors.white),
                ),
                child: SvgPicture.asset('assets/icons/messages.svg'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var color = isSelected ? Theme.of(context).primaryColor : Colors.grey[600];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(icon, size: 32, color: color),
          ),
        ),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
