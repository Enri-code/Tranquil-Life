part of 'package:tranquil_life/features/dashboard/presentation/screens/tabs/home.dart';

class _MoodsListView extends StatelessWidget {
  const _MoodsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(4),
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
                        padding: const EdgeInsets.fromLTRB(3, 3, 2, 2),
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
