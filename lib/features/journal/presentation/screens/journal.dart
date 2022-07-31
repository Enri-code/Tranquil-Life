import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note.dart';

class JournalsScreen extends StatelessWidget {
  static const routeName = 'journal_screen';
  const JournalsScreen({Key? key}) : super(key: key);

/*   static final _notes = [
    Note(
      title: 'I never liked therapy, so I was jittery, but my first',
      description: 'description',
      dateUpdated: DateTime.now(),
    ),
    Note(
      title:
          'I never liked therapy, so I was jittery, but my first session. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      dateUpdated: DateTime.now().add(const Duration(days: 1)),
    ),
    Note(
      title: 'Short note',
      description: 'description',
      dateUpdated: DateTime.now(),
    ),
    Note(
      title:
          'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      dateUpdated: DateTime.now(),
    ),
    Note(
      title: 'Short note',
      description: 'description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Note(
      title: 'Short note',
      description: 'description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Note(
      title:
          'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
 */
  static Widget _gridBuilder(Note note) {
    final noteWidget = NoteWidget(note: note);
    if (note.title.length > 60) {
      return StaggeredGridTile.fit(
        crossAxisCellCount: 2,
        child: noteWidget,
      );
    }
    return noteWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Journals'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(Icons.search_rounded),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 48),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                ),
                onSubmitted: (val) {},
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SafeArea(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      children: List.generate(
                          1, (i) => Container() //_gridBuilder(_notes[i]),
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
