import 'package:flutter/material.dart';
import 'package:tranquil_life/core/constants/genders.dart';

class SelectGenderSheet extends StatelessWidget {
  const SelectGenderSheet({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String newGender) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'What is your gender?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                genders.length,
                (index) {
                  final value = genders[index].title;
                  return InkResponse(
                    onTap: () {
                      onChanged(value);
                      Navigator.of(context).pop();
                    },
                    containedInkWell: true,
                    highlightShape: BoxShape.rectangle,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(value),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
