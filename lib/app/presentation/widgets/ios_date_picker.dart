import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IOSDatePicker extends StatelessWidget {
  IOSDatePicker({
    Key? key,
    required this.minDate,
    required this.maxDate,
    this.initialDate,
  }) : super(key: key);

  final DateTime minDate, maxDate;
  final DateTime? initialDate;

  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    selectedDate = initialDate ?? maxDate;
    return SafeArea(
      top: false,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CupertinoDatePicker(
            minimumDate: minDate,
            maximumDate: maxDate,
            initialDateTime: initialDate ?? maxDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (date) => selectedDate = date,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(selectedDate),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
