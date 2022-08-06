import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/dashboard/presentation/widgets/consultant_card.dart';

class SpeakWithConsultantScreen extends StatelessWidget {
  static const routeName = 'speak_with_consultant';
  const SpeakWithConsultantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Speak with a consultant'),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 4),
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ConsultantCard(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
