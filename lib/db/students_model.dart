import 'package:hive/hive.dart';

part 'students_model.g.dart';

@HiveType(typeId: 2)
class Students extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String studentName;

  @HiveField(2)
  final int mobileNo;

  @HiveField(3)
  final String loginPassword;

  Students(
      {required this.id,
      required this.studentName,
      required this.mobileNo,
      required this.loginPassword});
}
