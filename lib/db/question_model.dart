import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final int answerChoicesID;

  Question(
      {required this.id,
      required this.question,
      required this.answerChoicesID});
  // Create a fromMap factory method
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      question: map['question'] as String,
      answerChoicesID: map['answerChoicesID'] as int,
    );
  }

  // Optional: Convert a Question instance to Map if needed
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answerChoicesID': answerChoicesID,
    };
  }
}
