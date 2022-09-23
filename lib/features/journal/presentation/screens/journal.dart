import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/delete_dialog.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note.dart';

enum JournalSelectType { none, share, delete }

class JournalsScreen extends StatefulWidget {
  static const routeName = 'journal_screen';
  const JournalsScreen({Key? key}) : super(key: key);

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen> {
  final selectedNotes = <SavedNote>[];
  JournalSelectType selectType = JournalSelectType.none;

  void _cancelSelection() => setState(() {
        selectedNotes.clear();
        selectType = JournalSelectType.none;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Journal',
        actions: [
          if (selectType != JournalSelectType.none)
            AppBarAction(
              child: const Icon(Icons.cancel_outlined),
              onPressed: _cancelSelection,
            ),
        ],
      ),
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
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 66),
                    child: SafeArea(
                      child: MultiRepositoryProvider(
                        providers: [
                          RepositoryProvider.value(value: selectedNotes),
                          RepositoryProvider.value(value: selectType),
                        ],
                        child: BlocBuilder<JournalBloc, JournalState>(
                          builder: (context, state) {
                            return StaggeredGrid.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 14,
                              children: List.generate(
                                state.notes.length,
                                (i) => _SelectableNoteWidget(state.notes[i]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  child: SafeArea(
                    child: Builder(
                      builder: (context) {
                        switch (selectType) {
                          case JournalSelectType.delete:
                            return GestureDetector(
                              onTap: () async {
                                final notes =
                                    List<SavedNote>.from(selectedNotes);
                                await showDialog(
                                  context: context,
                                  builder: (_) =>
                                      DeleteNotesDialog(notes: notes),
                                );
                                _cancelSelection();
                              },
                              child: const _Dial(
                                icon: TranquilIcons.trash,
                                size: 26,
                              ),
                            );
                          case JournalSelectType.share:
                            return GestureDetector(
                              onTap: () async {
                                final notes =
                                    List<SavedNote>.from(selectedNotes);
                                /*   await showDialog(
                                  context: context,
                                  builder: (_) => ShareNotesDialog(notes),
                                ); */
                                _cancelSelection();
                              },
                              child: const _Dial(
                                icon: CupertinoIcons.share_solid,
                                size: 26,
                              ),
                            );
                          default:
                            return SpeedDial(
                              elevation: 0,
                              overlayOpacity: 0.3,
                              spaceBetweenChildren: 12,
                              overlayColor: Colors.black,
                              backgroundColor: Theme.of(context).primaryColor,
                              children: [
                                SpeedDialChild(
                                  child: const _DialChild(
                                      icon: TranquilIcons.new_note),
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(NoteScreen.routeName),
                                ),
                                SpeedDialChild(
                                    child: const _DialChild(
                                      icon: CupertinoIcons.share_solid,
                                    ),
                                    onTap: () => setState(() {
                                          selectType = JournalSelectType.share;
                                        })),
                                SpeedDialChild(
                                    child: const _DialChild(
                                      icon: TranquilIcons.trash,
                                    ),
                                    onTap: () => setState(() {
                                          selectType = JournalSelectType.delete;
                                        })),
                              ],
                              activeChild: const _Dial(icon: Icons.close),
                              child: const _Dial(icon: TranquilIcons.menu),
                            );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SelectableNoteWidget extends StatefulWidget {
  const _SelectableNoteWidget(this.note, {Key? key}) : super(key: key);
  final SavedNote note;

  @override
  State<_SelectableNoteWidget> createState() => _SelectableNoteWidgetState();
}

class _SelectableNoteWidgetState extends State<_SelectableNoteWidget> {
  @override
  Widget build(BuildContext context) {
    final isSelectState =
        context.watch<JournalSelectType>() != JournalSelectType.none;
    final savedNotes = context.read<List<SavedNote>>();

    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            NoteScreen.routeName,
            arguments: widget.note,
          ),
          onLongPress: () => showNoteDialog(context, widget.note),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.width * 0.3,
            ),
            child: BlocBuilder<NoteBloc, NoteState>(
              buildWhen: (_, current) => current.affectedNote == widget.note,
              builder: (context, state) => NoteWidget(note: widget.note),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: !isSelectState,
          child: AnimatedOpacity(
            duration: kThemeChangeDuration,
            opacity: isSelectState ? 1 : 0,
            child: Checkbox(
              value: savedNotes.contains(widget.note),
              onChanged: (val) => setState(() {
                if (val == true) {
                  savedNotes.add(widget.note);
                } else {
                  savedNotes.remove(widget.note);
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _Dial extends StatelessWidget {
  const _Dial({Key? key, required this.icon, this.size}) : super(key: key);
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      onPressed: null,
      child: Icon(icon, size: size ?? 30),
    );
  }
}

class _DialChild extends StatelessWidget {
  const _DialChild({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      onPressed: null,
      child: Icon(icon),
    );
  }
}
