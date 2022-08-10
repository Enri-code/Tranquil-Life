import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

class NoteScreen extends StatefulWidget {
  /// argument can be a [Note]
  static const routeName = 'note_screen';
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  final _nowDate = DateTime.now();

  late Note? _note;
  bool _canSave = false;
  late String heroPrefix;

  @override
  void didChangeDependencies() {
    _note = ModalRoute.of(context)?.settings.arguments as Note?;
    heroPrefix = _note is SavedNote ? 'saved' : 'home';
    //_note ??= Note(title: '', description: '', dateUpdated: DateTime.now());
    _titleTextController.text = _note?.title ?? '';
    _bodyTextController.text = _note?.description ?? '';
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
        title: 'Note',
        //onBackPressed: () {},
        actions: [
          if (_canSave)
            AppBarAction(
              child: const Icon(Icons.done, color: Colors.white),
              onPressed: () {
                _note = Note(
                  title: _titleTextController.text,
                  description: _bodyTextController.text,
                  emoji: _note?.emoji,
                );
              },
            ),
          AppBarAction(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.more_vert, color: ColorPalette.primary[800]),
            ),
            isCustomButton: false,
            onPressed: () => showNoteDialog(context, _note),
          ),
        ],
      ),
      body: UnfocusWidget(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: null,
                maxLength: 150,
                controller: _titleTextController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(height: 1.3, fontSize: 29),
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Title...',
                  hintStyle: TextStyle(fontSize: 28),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: (val) => setState(() => _canSave = val.isNotEmpty),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              _nowDate.formatted,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (_note?.emoji != null)
                            Hero(
                              tag: '$heroPrefix-${_note!.emoji!}',
                              child: Text(
                                _note!.emoji!,
                                style: Platform.isIOS
                                    ? const TextStyle(fontSize: 48)
                                    : const TextStyle(fontSize: 40),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SafeArea(
                        child: TextField(
                          minLines: 5,
                          maxLines: null,
                          controller: _bodyTextController,
                          textInputAction: TextInputAction.newline,
                          style: const TextStyle(fontSize: 18, height: 1.35),
                          decoration: const InputDecoration(
                            filled: false,
                            hintText: "What's on your mind today?",
                            hintStyle: TextStyle(fontSize: 19),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onChanged: (val) => setState(() {
                            _canSave = val.isNotEmpty &&
                                _titleTextController.text.isNotEmpty;
                          }),
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
