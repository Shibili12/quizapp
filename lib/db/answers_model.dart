import 'package:hive/hive.dart';

part 'answers_model.g.dart';

@HiveType(typeId: 3)
class Answers extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int studentId;

  @HiveField(2)
  final int questionId;

  @HiveField(3)
  final int choicesId;

  Answers(
      {required this.id,
      required this.studentId,
      required this.questionId,
      required this.choicesId});
}
