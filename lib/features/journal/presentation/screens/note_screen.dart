import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';

class NoteScreen extends StatefulWidget {
  /// argument should be a [Note?]
  static const routeName = 'note_screen';
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  late Note? note;

  late bool editMode;
  bool canSave = false;

  @override
  void didChangeDependencies() {
    note = ModalRoute.of(context)?.settings.arguments as Note?;
    editMode = note == null;
    _titleTextController.text = note?.title ?? '';
    _bodyTextController.text = note?.description ?? '';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _bodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Your note',
        actions: [
          if (!editMode)
            AppBarAction(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () => setState(() => editMode = true),
            )
          else if (canSave)
            AppBarAction(
              icon: const Icon(Icons.done, color: Colors.white),
              onPressed: () {
                note = Note(
                  title: _titleTextController.text,
                  description: _bodyTextController.text,
                  dateUpdated: DateTime.now(),
                );
                //TODO save
                setState(() => editMode = false);
              },
            )
          else
            AppBarAction(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () => setState(() => editMode = false),
            ),
        ],
      ),
      body: UnfocusWidget(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: null,
                readOnly: !editMode,
                controller: _titleTextController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(height: 1.3, fontSize: 29),
                decoration: const InputDecoration(
                  hintText: 'Title of this note...',
                  hintStyle: TextStyle(fontSize: 28),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (val) => setState(() => canSave = val.isNotEmpty),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'July 30, 2022.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SafeArea(
                        child: TextField(
                          maxLines: null,
                          readOnly: !editMode,
                          controller: _bodyTextController,
                          textInputAction: TextInputAction.newline,
                          style: const TextStyle(fontSize: 18, height: 1.35),
                          decoration: const InputDecoration(
                            hintText: "What's on your mind today?",
                            hintStyle: TextStyle(fontSize: 19),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
