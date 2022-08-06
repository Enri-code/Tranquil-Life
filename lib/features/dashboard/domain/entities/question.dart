class Question {
  Question({required this.title, required this.options});

  final String title;
  final List<Option> options;

  Option? answer;
}

class Option {
  final String title;
  final Question? subQuestion;

  const Option(this.title, {this.subQuestion});
}
