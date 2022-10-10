import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/extensions/hex_color.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({Key? key, required this.note}) : super(key: key);
  final SavedNote note;
  static const _defaultNoteColor = Color(0xFFFDFDFD);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: note.hexColor?.toColor() ?? _defaultNoteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  note.dateUpdated?.formatted ?? '',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          if (note.mood != null)
            Positioned(
              bottom: Platform.isIOS ? -8 : -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.only(top: 6, left: 3),
                decoration: const BoxDecoration(
                  color: _defaultNoteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Hero(
                  tag: 'saved-${note.mood!}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      note.mood!,
                      style: Platform.isIOS
                          ? const TextStyle(fontSize: 37)
                          : const TextStyle(fontSize: 31),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
