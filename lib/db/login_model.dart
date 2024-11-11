import 'package:hive/hive.dart';

part 'login_model.g.dart';

@HiveType(typeId: 4)
class LoginModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String loginId;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final bool isAdmin;

  LoginModel(
      {required this.id,
      required this.loginId,
      required this.password,
      required this.isAdmin});
}
