import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(note.colorInt),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 17,
              height: 1.35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            note.dateUpdated.formatted,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
