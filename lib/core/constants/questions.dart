import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/core/constants/genders.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/domain/entities/question.dart';

final questions = <Question>[
  Question(
    0,
    title: 'What is your gender?',
    options: const [...genders, Option('Choose not to say')],
    onAnswer: (answer) {
      if (answer.title == 'Choose not to say') return;
      getIt<ProfileBloc>().add(UpdateUser(gender: answer.title));
    },
  ),
  Question(
    1,
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
    2,
    title: 'Do you consider yourself to be religious?',
    options: [
      Option(
        'Yes',
        subQuestion: Question(
          0,
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
    3,
    title: 'Have you ever had professional counselling or therapy?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    4,
    title: 'Have you ever had a group therapy session?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    5,
    title: 'How have you been feeling lately?',
    options: const [
      Option('Good'),
      Option('Stressed'),
      Option('Sad'),
      Option('Indifferent'),
    ],
  ),
  Question(
    6,
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
    7,
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
    8,
    title: 'Are you currently taking any medication?',
    options: const [Option('Yes'), Option('No')],
  ),
  Question(
    9,
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
