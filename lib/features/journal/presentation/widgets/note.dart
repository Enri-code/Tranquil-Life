import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({Key? key, required this.note}) : super(key: key);
  final SavedNote note;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(note.colorInt),
        borderRadius: BorderRadius.circular(8),
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
                  style: const TextStyle(fontSize: 17, height: 1.4),
                ),
                const SizedBox(height: 26),
                Text(
                  note.dateUpdated?.formatted ?? '',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          if (note.emoji != null)
            Positioned(
              bottom: Platform.isIOS ? -8 : -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.only(top: 6, left: 3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Hero(
                  tag: 'saved-${note.emoji!}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      note.emoji!,
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
