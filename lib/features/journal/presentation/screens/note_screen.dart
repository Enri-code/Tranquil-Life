import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/extensions/hex_color.dart';
import 'package:tranquil_life/core/utils/functions.dart';
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
    return _BGWidget(
      backgroundColor: _note.hexColor?.toColor(),
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
              child: const Icon(Icons.more_vert),
              onPressed: () async => showNoteDialog(
                context,
                _note,
                onNoteDeleted: Navigator.of(context).pop,
                onColorChanged: (color) {
                  setState(() => _note.hexColor = color?.toHex());
                  if (!isAlreadySaved) return;
                  context.read<NoteBloc>().add(UpdateNote(_note as SavedNote));
                },
              ),
            ),
        ],
      ),
      child: UnfocusWidget(
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
                          if (_note.mood != null)
                            Hero(
                              tag:
                                  '${isAlreadySaved ? 'saved' : 'home'}-${_note.mood!}',
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text(
                                  _note.mood!,
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
                            hintText: "What's on your mind?",
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

class _BGWidget extends StatefulWidget {
  const _BGWidget({
    Key? key,
    required this.appBar,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);
  final PreferredSizeWidget appBar;
  final Widget child;
  final Color? backgroundColor;

  @override
  State<_BGWidget> createState() => __BGWidgetState();
}

class __BGWidgetState extends State<_BGWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animController;
  Color? backgroundColor = Colors.white;
  Color? lastBackgroundColor = Colors.white;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: kThemeChangeDuration,
    )..animateTo(1, duration: Duration.zero);
    setBGColor();
    super.initState();
  }

  void setBGColor() => backgroundColor = Color.lerp(
        widget.backgroundColor ?? Colors.white,
        Colors.white,
        0.2,
      );

  @override
  void didUpdateWidget(covariant _BGWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    lastBackgroundColor = backgroundColor;
    setBGColor();
    animController.forward(from: 0);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animController,
      builder: (context, child) {
        return Scaffold(
          body: child,
          appBar: widget.appBar,
          backgroundColor: Color.lerp(
            lastBackgroundColor,
            backgroundColor,
            animController.value,
          ),
        );
      },
      child: widget.child,
    );
  }
}
