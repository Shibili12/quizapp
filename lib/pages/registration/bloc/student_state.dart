part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class RegistrationLoading extends StudentState {}

class RegistrationSuccess extends StudentState {}

class RegistrationFailure extends StudentState {
  final String message;

  RegistrationFailure(this.message);

  @override
  List<Object> get props => [message];
}
