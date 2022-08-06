import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/constants/moods.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note.dart';

class JournalsScreen extends StatelessWidget {
  static const routeName = 'journal_screen';
  const JournalsScreen({Key? key}) : super(key: key);

  static final _notes = [
    SavedNote(
      id: '7',
      title: 'I never liked therapy, so I was jittery, but my first',
      description: 'Description',
      emoji: moods[0],
      colorInt: 0xffC0E2C9,
      dateUpdated: DateTime.now(),
    ),
    SavedNote(
      id: '6',
      title:
          'I never liked therapy, so I was jittery, but my first session. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      emoji: moods[1],
      dateUpdated: DateTime.now().add(const Duration(days: 1)),
    ),
    SavedNote(
      id: '0',
      title: 'Short note',
      description: 'Description',
      dateUpdated: DateTime.now(),
    ),
    SavedNote(
      id: '1',
      title:
          'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      colorInt: 0xffA1D4AE,
      dateUpdated: DateTime.now(),
    ),
    SavedNote(
      id: '2',
      title: 'Short note',
      description: 'Description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
      emoji: moods[4],
      colorInt: 0xffC0E2C9,
    ),
    SavedNote(
      id: '3',
      title: 'Short note',
      description: 'Description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SavedNote(
      id: '4',
      title:
          'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
      description: 'Long description',
      dateUpdated: DateTime.now().subtract(const Duration(days: 3)),
      colorInt: 0xffC0E2C9,
    ),
  ];

  static Widget _gridBuilder(BuildContext context, SavedNote note) {
    final noteWidget = NoteWidget(note: note);
/*     if (note.title.length > 60) {
      return StaggeredGridTile.fit(crossAxisCellCount: 2, child: noteWidget);
    } */
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NoteScreen.routeName, arguments: note);
      },
      onLongPress: () => showNoteDialog(context, note),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.width * 0.3),
        child: noteWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Journal'),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SafeArea(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 14,
                    children: List.generate(
                      _notes.length,
                      (i) => _gridBuilder(context, _notes[i]),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
