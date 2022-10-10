import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/widgets/ios_date_picker.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/presentation/widgets/note_bottom_sheet.dart';

final getIt = GetIt.instance.get;

void setStatusBarBrightness(bool dark, [Duration? delayedTime]) async {
  await Future.delayed(delayedTime ?? const Duration(milliseconds: 300));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: dark ? Brightness.dark : Brightness.light,
    statusBarBrightness: dark ? Brightness.light : Brightness.dark,
  ));
}

Future<bool> addMeetingToCalendar(DateTime time) {
  return Add2Calendar.addEvent2Cal(Event(
    title: 'TL consultation',
    description:
        'This is a scheduled meeting with a consultant on ${AppConfig.appName}',
    location: AppConfig.appName,
    startDate: time,
    endDate: time.add(const Duration(hours: 1)),
    androidParams: const AndroidParams(),
    iosParams: const IOSParams(reminder: Duration(hours: 2)),
  ));
}

Future<DateTime?> showCustomDatePicker(BuildContext context,
    {DateTime? minDateFromNow, DateTime? maxDateFromNow}) {
  var now = DateTime.now();

  var min = DateTime(
    now.year + (minDateFromNow?.year ?? 0),
    now.month + (minDateFromNow?.month ?? 0),
    now.day,
  );
  var max = DateTime(
    now.year + maxDateFromNow!.year,
    now.month + maxDateFromNow.month,
    now.day,
  );

  final initial = now.isBefore(max) ? now : max;

  if (Platform.isIOS) {
    return showModalBottomSheet<DateTime>(
      context: context,
      builder: (_) =>
          IOSDatePicker(minDate: min, maxDate: max, initialDate: initial),
    );
  }
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: min,
    lastDate: max,
  );
}

Future<Color?> showNoteDialog(BuildContext context, Note note,
    {Function(Color?)? onColorChanged, Function()? onNoteDeleted}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.black26,
    backgroundColor: Colors.transparent,
    builder: (_) => NoteBottomSheet(
      note,
      onColorChanged: onColorChanged,
      onNoteDeleted: onNoteDeleted,
    ),
  );
}
