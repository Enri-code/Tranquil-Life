import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/extensions/hex_color.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';

class NoteScreen extends StatefulWidget {
  /// argument can be a [Note]?
  static const routeName = 'note_screen';
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  final _nowDate = DateTime.now();

  bool _canSave = false;

  late Note _note;
  late bool isAlreadySaved;

  @override
  void didChangeDependencies() {
    _note = ModalRoute.of(context)?.settings.arguments as Note? ?? Note();
    isAlreadySaved = _note is SavedNote;
    _titleTextController.text = _note.title;
    _bodyTextController.text = _note.description;
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
        actions: [
          if (_canSave)
            AppBarAction(
              child: const Icon(Icons.done, color: Colors.white),
              onPressed: () {
                _note.title = _titleTextController.text;
                _note.description = _bodyTextController.text;
                setState(() => _canSave = false);
              },
            )
          else
            AppBarAction(
              isCustomButton: false,
              child: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async => showNoteDialog(
                context,
                _note,
                onColorChanged: (color) {
                  _note.hexColor = color?.toHex();
                  if (isAlreadySaved) {
                    context
                        .read<NoteBloc>()
                        .add(UpdateNote(_note as SavedNote));
                  }
                },
              ),
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
                maxLength: _titleTextController.text.length < 100 ? null : 150,
                controller: _titleTextController,
                textInputAction: TextInputAction.done,
                style: const TextStyle(height: 1.3, fontSize: 29),
                maxLengthEnforcement:
                    MaxLengthEnforcement.truncateAfterCompositionEnds,
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
                          if (_note.emoji != null)
                            Hero(
                              tag:
                                  '${isAlreadySaved ? 'saved' : 'home'}-${_note.emoji!}',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  _note.emoji!,
                                  style: Platform.isIOS
                                      ? const TextStyle(fontSize: 48)
                                      : const TextStyle(fontSize: 40),
                                ),
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
                          onChanged: (val) => setState(() =>
                              _canSave = _titleTextController.text.isNotEmpty),
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
