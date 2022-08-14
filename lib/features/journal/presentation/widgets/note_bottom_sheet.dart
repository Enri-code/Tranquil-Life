import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/core/constants/note_colors.dart';
import 'package:tranquil_life/core/utils/extensions/hex_color.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/delete_dialog.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/share_note_sheet.dart';

class NoteBottomSheet extends StatefulWidget {
  const NoteBottomSheet(this.note, {Key? key, this.onColorChanged})
      : super(key: key);

  final Note note;
  final Function(Color?)? onColorChanged;

  @override
  State<NoteBottomSheet> createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  Color? selectedColor;

  @override
  void initState() {
    selectedColor = widget.note.hexColor?.toColor();
    super.initState();
  }

  _onChooseColor(Color? color) {
    setState(() => selectedColor = color);
    widget.onColorChanged?.call(color);
  }

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
                  children: [
                    GestureDetector(
                      onTap: () => _onChooseColor(null),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: Icon(Icons.cancel_outlined, size: 30),
                      ),
                    ),
                    ...List.generate(
                      colors.length,
                      (index) {
                        var color = colors[index];
                        return GestureDetector(
                          onTap: () => _onChooseColor(color),
                          child: _ColorCircle(
                            color,
                            isSelected: color == selectedColor,
                          ),
                        );
                      },
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.black, height: 24),
          Column(
            children: [
              _Option(
                label: 'Share note with a consultant',
                icon: const Icon(CupertinoIcons.share),
                onPressed: () {
                  Navigator.of(context).pop();
                  return showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => ShareNoteBottomSheet(widget.note),
                  );
                },
              ),
              const SizedBox(height: 4),
              _Option(
                label: 'Delete note',
                icon: const Icon(CupertinoIcons.delete),
                onPressed: () {
                  Navigator.of(context).pop();
                  return showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: DeleteNoteDialog(note: widget.note),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  const _ColorCircle(this.color, {Key? key, required this.isSelected})
      : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          width: 30,
          height: 30,
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: isSelected ? Border.all(color: Colors.black) : null,
          ),
        ),
        AnimatedOpacity(
          opacity: isSelected ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.check, color: Colors.white),
        ),
      ],
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
