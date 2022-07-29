import 'package:flutter/material.dart';
import 'package:tranquil_life/features/dashboard/client/domain/entities/mood.dart';

const _moods = <Mood>[
  Mood('😍', 'In Love'),
];

class MoodsListView extends StatelessWidget {
  const MoodsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _moods.length,
            itemBuilder: (_, i) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _moods[i].emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                  Text(
                    _moods[i].mood,
                    //style: TextStyle(fontSize: 32),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
