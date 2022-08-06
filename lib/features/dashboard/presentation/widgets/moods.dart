import 'package:flutter/material.dart';
import 'package:tranquil_life/core/constants/moods.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';

class MoodsListView extends StatelessWidget {
  const MoodsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 7,
            clipBehavior: Clip.none,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              moods.length,
              (i) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  NoteScreen.routeName,
                  arguments: Note(title: '', emoji: moods[i]),
                ),
                child: Hero(
                  tag: 'home-${moods[i]}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, top: 2),
                        child: Text(moods[i]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
