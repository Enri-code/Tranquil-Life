import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/widgets/consultant_card.dart';

class SpeakWithConsultantScreen extends StatelessWidget {
  static const routeName = 'speak_with_consultant';
  const SpeakWithConsultantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Speak with a consultant'),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 4),
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
                        child: ConsultantCard(
                          consultant: Consultant(
                            id: '$index',
                            specialties:
                                'Anxiety, self-esteem, and depression.',
                            description:
                                'Specialist in matters relating to anxiety, self-esteem, and depression.',
                            name: 'Dr David Blaine Mckenzie',
                            avatarUrl:
                                'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
                          ),
                        ),
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
