part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends StudentEvent {
  final String username;
  final int mobileNumber;
  final String password;

  RegisterUser(this.username, this.mobileNumber, this.password);

  @override
  List<Object> get props => [username, mobileNumber, password];
}
