class Question {
  Question({required this.title, required this.options, this.onAnswer});

  final String title;
  final List<Option> options;
  final Function(Option)? onAnswer;
  Option? answer;

  Map<String, dynamic>? toJson() {
    if (answer == null) return null;
    var subQuestion = answer!.subQuestion?.toJson();
    var map = <String, dynamic>{
      'question': title,
      'answer': answer!.title,
      if (subQuestion != null) 'sub_question': subQuestion,
    };
    return map;
  }
}

class Option {
  final String title;
  final Question? subQuestion;

  const Option(this.title, {this.subQuestion});
}
