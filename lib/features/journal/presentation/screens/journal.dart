import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note.dart';
import 'package:tranquil_life/samples/notes.dart';

class JournalsScreen extends StatelessWidget {
  static const routeName = 'journal_screen';
  const JournalsScreen({Key? key}) : super(key: key);

  Widget _gridBuilder(BuildContext context, SavedNote note) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NoteScreen.routeName, arguments: note);
      },
      onLongPress: () => showNoteDialog(context, note),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.width * 0.3),
        child: BlocBuilder<NoteBloc, NoteState>(
          buildWhen: (_, current) => current.affectedNote == note,
          builder: (context, state) => NoteWidget(note: note),
        ),
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
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 66),
                    child: SafeArea(
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 14,
                        children: List.generate(
                          notes.length,
                          (i) => _gridBuilder(context, notes[i]),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  child: SafeArea(
                    child: SpeedDial(
                      elevation: 0,
                      overlayOpacity: 0.3,
                      spaceBetweenChildren: 12,
                      overlayColor: Colors.black,
                      backgroundColor: Theme.of(context).primaryColor,
                      children: [
                        SpeedDialChild(
                          child: const _DialChild(icon: TranquilIcons.new_note),
                          onTap: () => Navigator.of(context)
                              .pushNamed(NoteScreen.routeName),
                        ),
                        SpeedDialChild(
                          child: const _DialChild(
                            icon: CupertinoIcons.share_solid,
                          ),
                          onTap: () {},
                        ),
                        SpeedDialChild(
                          child: const _DialChild(icon: TranquilIcons.trash),
                          onTap: () {},
                        ),
                      ],
                      activeChild: const _Dial(icon: Icons.close),
                      child: const _Dial(icon: TranquilIcons.menu),
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

class _Dial extends StatelessWidget {
  const _Dial({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      onPressed: null,
      child: Icon(icon, size: 30),
    );
  }
}

class _DialChild extends StatelessWidget {
  const _DialChild({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      onPressed: null,
      child: Icon(icon),
    );
  }
}
