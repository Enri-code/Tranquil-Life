import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/core/constants/genders.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';

final questions = <Question>[
  Question(
    title: 'What is your gender?',
    options: const [...genders, Option('Choose not to say')],
    onAnswer: (answer) {
      if (answer.title == 'Choose not to say') return;
      getIt<ProfileBloc>().add(UpdateUser(gender: answer.title));
    },
  ),
  Question(
    title: 'What is your relationship status?',
    options: const [
      Option('Single'),
      Option('In a relationship'),
      Option('Married'),
      Option('Divorced'),
      Option('Widowed'),
      Option('Other'),
    ],
  ),
  Question(
    title: 'Do you consider yourself to be religious?',
    options: [
      Option(
        'Yes',
        subQuestion: Question(
          title: 'What religion do you identify with?',
          options: const [
            Option('Christianity'),
            Option('Islam'),
            Option('Judaism'),
            Option('African traditional religion'),
            Option('Other'),
          ],
        ),
      ),
      const Option('No'),
    ],
  ),
  Question(
    title: 'Have you ever had professional counselling or therapy?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    title: 'Have you ever had a group therapy session?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    title: 'How have you been feeling lately?',
    options: const [
      Option('Good'),
      Option('Stressed'),
      Option('Sad'),
      Option('Indifferent'),
    ],
  ),
  Question(
    title: 'What is typically the largest source of your stress and sadness?',
    options: const [
      Option('Finances'),
      Option('Health'),
      Option('Work'),
      Option('Home life or Relationships'),
      Option('Bereavement or Loss'),
    ],
  ),
  Question(
    title: 'How does stress usually affect you?',
    options: const [
      Option('Moodiness'),
      Option('Difficulty sleeping'),
      Option('Physical discomfort'),
      Option('Anxious feelings'),
      Option('Panic attacks'),
    ],
  ),
  Question(
    title: 'Are you currently taking any medication?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    title: 'What referred you to ${AppConfig.appName}?',
    options: const [
      Option('Friend or Family member'),
      Option('Social media'),
      Option('Youtube'),
      Option('Google Ad'),
      Option('Other'),
    ],
  ),
];
