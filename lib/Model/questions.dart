class QuestionModel {
  int id;
  int answer;
  String question;
  List<String> options;
  QuestionModel(
      {required this.id,
        required this.question,
        required this.answer,
      required this.options,
      });
}
