import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tranquil_life/app/presentation/widgets/ios_date_picker.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note_bottom_sheet.dart';

void setStatusBarBrightness(bool dark, [Duration? delayedTime]) async {
  if (delayedTime != null) await Future.delayed(delayedTime);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: dark ? Brightness.dark : Brightness.light,
    statusBarBrightness: dark ? Brightness.light : Brightness.dark,
  ));
}

Future<DateTime?> showCustomDatePicker(BuildContext context,
    {required DateTime minDateFromNow, required DateTime maxDateFromNow}) {
  var now = DateTime.now();
/*
  var min = DateTime(now.year - 100, now.month, now.day);
  var max = DateTime(now.year - 16, now.month, now.day);
*/
  var min = DateTime(
    now.year + minDateFromNow.year,
    now.month + minDateFromNow.month,
    now.day,
  );
  var max = DateTime(
    now.year + maxDateFromNow.year,
    now.month + maxDateFromNow.month,
    now.day,
  );

  if (Platform.isIOS) {
    return showModalBottomSheet<DateTime>(
      context: context,
      builder: (_) => IOSDatePicker(
        minDate: min,
        maxDate: max,
        initialDate: max,
      ),
    );
  }
  return showDatePicker(
    context: context,
    initialDate: now,
    firstDate: min,
    lastDate: max,
  );
}

Future<Color?> showNoteDialog(BuildContext context, Note note) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => NoteBottomSheet(note),
    );
