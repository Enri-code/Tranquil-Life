import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';

class QuestionBottomSheet extends StatefulWidget {
  const QuestionBottomSheet(this.question, {Key? key}) : super(key: key);
  final Question question;

  @override
  State<QuestionBottomSheet> createState() => _QuestionBottomSheetState();
}

class _QuestionBottomSheetState extends State<QuestionBottomSheet> {
  void _onSelect(Option option) async {
    setState(() => widget.question.answer = option);
    final navigator = Navigator.of(context);
    await Future.delayed(kThemeAnimationDuration);
    navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black26,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.question.title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.question.options.length,
                    (i) {
                      var option = widget.question.options[i];
                      return OptionWidget(
                        option,
                        isSelected: widget.question.answer == option,
                        onTap: (_) => _onSelect(option),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget(
    this.option, {
    Key? key,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;
  final Option option;
  final Function(bool canContinue)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                isSelected ? ColorPalette.blue : Theme.of(context).primaryColor,
          ),
          onPressed: () {
            if (option.subQuestion != null) {
              showModalBottomSheet<bool>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => QuestionBottomSheet(
                  option.subQuestion!,
                ),
              ).then((val) => onTap?.call(val ?? false));
            } else {
              onTap?.call(true);
            }
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              option.title,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
