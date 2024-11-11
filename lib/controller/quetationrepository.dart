import 'package:hive/hive.dart';
import 'package:quizapp/db/question_model.dart';
import 'package:quizapp/db/choice_model.dart';

class HiveQuestionRepository {
  final Box<Question> questionBox = Hive.box<Question>('questionsBox');
  final Box<Choice> choicesBox = Hive.box<Choice>('choicesBox');

  final int _pageSize = 10;
  Future<List<Question>> getQuestions(int offset) async {
    final questions = questionBox.values.skip(offset).take(_pageSize).toList();

    return questions;
  }

  Future<List<Choice>> getChoicesForQuestion(int questionId) async {
    print(choicesBox.length.toString());
    final choices = choicesBox.values
        .where((choice) => choice.questionID == questionId)
        .toList();

    return choices;
  }
}
