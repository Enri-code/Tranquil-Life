import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/core/constants/note_colors.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class NoteBottomSheet extends StatelessWidget {
  const NoteBottomSheet({Key? key, this.note}) : super(key: key);
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            height: 32,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  colors.length,
                  (index) => Container(
                    width: 31,
                    height: 31,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.black, height: 24),
          Column(
            children: [
              _Option(
                label: 'Share note with a consultant',
                icon: const Icon(CupertinoIcons.share),
                onPressed: () {},
              ),
              const SizedBox(height: 4),
              _Option(
                label: 'Delete note',
                icon: const Icon(CupertinoIcons.delete),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkResponse(
        onTap: onPressed,
        containedInkWell: true,
        highlightShape: BoxShape.rectangle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
