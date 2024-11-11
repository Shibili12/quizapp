import 'package:hive/hive.dart';

part 'choice_model.g.dart';

@HiveType(typeId: 1)
class Choice extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int questionID;

  @HiveField(2)
  final String choice;

  Choice({required this.id, required this.questionID, required this.choice});

  // Create a fromMap factory method
  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      id: map['id'] as int,
      questionID: map['questionID'] as int,
      choice: map['choice'] as String,
    );
  }

  // Optional: Convert a Choice instance to Map if needed
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionID': questionID,
      'choice': choice,
    };
  }
}
