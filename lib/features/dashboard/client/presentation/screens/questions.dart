import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    var index = 0;
    var questionsCount = 10;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/mountains_bg.png', fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: SliderComponentShape.noThumb,
                      trackHeight: 6,
                      disabledInactiveTrackColor: Colors.white,
                      disabledActiveTrackColor: Theme.of(context).primaryColor,
                    ),
                    child: Slider(
                      value: (index + 1) / questionsCount,
                      onChanged: null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Question ${index + 1}/$questionsCount',
                      style: TextStyle(
                        fontSize: 32,
                        letterSpacing: 1,
                        color: ColorPalette.primary[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'What is your gender?',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  3,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6, bottom: 12),
                                    child: SizedBox(
                                      height: 52,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Choose not to say',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
