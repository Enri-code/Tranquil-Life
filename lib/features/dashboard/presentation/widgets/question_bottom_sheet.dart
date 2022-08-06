import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/features/dashboard/domain/entities/question.dart';

class QuestionBottomSheet extends StatelessWidget {
  const QuestionBottomSheet(this.question, {Key? key}) : super(key: key);
  final Question question;

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
            question.title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    question.options.length,
                    (i) {
                      var option = question.options[i];
                      return OptionWidget(
                        option,
                        onTap: (_) {
                          question.answer = option;
                          Navigator.of(context).pop();
                        },
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
  const OptionWidget(this.option, {Key? key, this.onTap}) : super(key: key);
  final Option option;
  final Function(bool canContinue)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 12),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            if (option.subQuestion != null) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => QuestionBottomSheet(
                  option.subQuestion!,
                ),
              ).then((_) => onTap?.call(true));
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
