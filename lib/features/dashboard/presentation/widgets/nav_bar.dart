import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/features/journal/presentation/screens/journal.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.onPageChanged}) : super(key: key);
  final void Function(int page) onPageChanged;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  void _onTap(int index) {
    widget.onPageChanged(index);
    setState(() => currentIndex = index);
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
            padding: const EdgeInsets.only(top: 4, bottom: 2),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Item(
                    label: 'Home',
                    iconData: TranquilIcons.home,
                    isSelected: currentIndex == 0,
                    onTap: () => _onTap(0),
                  ),
                  _Item(
                    label: 'Wallet',
                    iconData: TranquilIcons.wallet,
                    isSelected: currentIndex == 1,
                    onTap: () => _onTap(1),
                  ),
                  const SizedBox(width: 32),
                  SpeedDial(
                    elevation: 0,
                    spaceBetweenChildren: 16,
                    overlayOpacity: 0.3,
                    overlayColor: Colors.black,
                    childPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    useRotationAnimation: false,
                    children: [
                      SpeedDialChild(
                        shape: const CircleBorder(),
                        child: const _Item(iconData: TranquilIcons.new_note),
                        onTap: () => Navigator.of(context)
                            .pushNamed(NoteScreen.routeName),
                      ),
                      SpeedDialChild(
                        shape: const CircleBorder(),
                        child: const _Item(iconData: TranquilIcons.view_note),
                        onTap: () => Navigator.of(context)
                            .pushNamed(JournalsScreen.routeName),
                      ),
                    ],
                    activeChild: const _Item(
                      label: 'Notes',
                      iconData: TranquilIcons.book_saved,
                      isSelected: true,
                    ),
                    child: const _Item(
                      label: 'Notes',
                      iconData: TranquilIcons.book_saved,
                      isSelected: false,
                    ),
                  ),
                  _Item(
                    label: 'Profile',
                    iconData: TranquilIcons.profile,
                    isSelected: currentIndex == 2,
                    onTap: () => _onTap(2),
                  ),
                ],
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -20),
          child: SafeArea(
            top: false,
            child: GestureDetector(
              onTap: () => widget.onPageChanged(3),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  border: Border.all(width: 7, color: Colors.white),
                ),
                child: const Icon(TranquilIcons.messages,
                    size: 32, color: Colors.white),
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
    required this.iconData,
    this.label,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  final String? label;
  final IconData iconData;
  final bool? isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var color = (isSelected ?? true)
        ? Theme.of(context).primaryColor
        : Colors.grey[600];
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(iconData, size: 28, color: color),
          ),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}
