import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/constants/questions.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/app/presentation/widgets/mountain_bg.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/questionnaire/presentation/bloc/questionnaire_bloc.dart';
import 'package:tranquil_life/features/questionnaire/presentation/widgets/question_bottom_sheet.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = 'questionnaire_screen';
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int index = 0, lastAnsweredIndex = -1;

  var questionsCount = questions.length;
  bool get isDone => questions.every((e) => e.answer != null);

  void _setLastAnsweredIndex() {
    lastAnsweredIndex = questions.length;
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].answer == null) {
        lastAnsweredIndex = i - 1;
        break;
      }
    }
  }

  _onOptionTap(bool canContinue, Option option) async {
    final answer = canContinue ? option : null;
    setState(() => questions[index].answer = answer);
    questions[index].onAnswer?.call(option);
    await Future.delayed(kThemeChangeDuration);
    _setLastAnsweredIndex();
    if (mounted && canContinue && index < questions.length - 1) {
      setState(() => index++);
    }
  }

  @override
  void initState() {
    _setLastAnsweredIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBGWidget(
      child: Column(
        children: [
          CustomAppBar(
            onBackPressed: index > 0 ? () => setState(() => index--) : null,
            actions: [
              if (index <= lastAnsweredIndex)
                AppBarAction(
                  child: const Padding(
                    padding: EdgeInsets.all(1),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () => setState(() => index++),
                ),
              if (isDone)
                AppBarAction(
                  child: const Padding(
                    padding: EdgeInsets.all(1),
                    child: Icon(Icons.check, color: Colors.white, size: 20),
                  ),
                  onPressed: () {
                    final bloc = context.read<QuestionnaireBloc>();
                    if (bloc.state.status == EventStatus.loading) return;
                    bloc.add(Submit(questions));
                  },
                ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: SliderComponentShape.noThumb,
              disabledInactiveTrackColor: Colors.white,
              disabledActiveTrackColor: Colors.orange,
            ),
            child: Slider(value: (index + 1) / questionsCount, onChanged: null),
          ),
          const SizedBox(height: 8),
          BlocListener<QuestionnaireBloc, QuestionnaireState>(
            listener: (context, state) {
              if (state.status == EventStatus.loading) {
                CustomLoader.display();
              } else {
                if (state.status == EventStatus.success) {
                  CustomLoader.remove();
                  //TODO: hasAnsweredQuestions = true
                  Navigator.of(context).popAndPushNamed(
                    SpeakWithConsultantScreen.routeName,
                  );
                } else if (state.status == EventStatus.error) {
                  CustomLoader.remove();
                }
              }
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Question ${index + 1}/$questionsCount',
                style: const TextStyle(fontSize: 32, letterSpacing: 1),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black26,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: AnimatedSize(
                duration: kThemeAnimationDuration,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      questions[index].title,
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            questions[index].options.length,
                            (i) {
                              var option = questions[index].options[i];
                              return OptionWidget(
                                option,
                                isSelected: questions[index].answer == option,
                                onTap: (val) => _onOptionTap(val, option),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
