import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/features/dashboard/client/domain/entities/mood.dart';

const _moods = <Mood>[
  Mood('😃', 'Happy'),
  Mood('😔', 'Sad'),
  Mood('😍', 'In Love'),
  Mood('😭', 'Crying'),
  Mood('😁', 'Excited'),
  Mood('😡', 'Angry'),
  Mood('😎', 'Cool'),
  Mood('🤔', 'Confused'),
  Mood('🤪', 'Crazy'),
  Mood('😫', 'Tired'),
  Mood('🤧', 'Sick'),
  Mood('😴', 'Sleepy'),
];

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
          child: Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                _moods.length,
                (i) => Column(
                  children: [
                    Text(
                      _moods[i].emoji,
                      style: const TextStyle(fontSize: 35),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorPalette.secondary,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        _moods[i].mood,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
