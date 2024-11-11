import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:quizapp/db/students_model.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegistrationLoading());
      final studentBox = Hive.box<Students>('studentsBox');

      bool userExists = studentBox.values
          .any((student) => student.studentName == event.username);
      if (userExists) {
        emit(RegistrationFailure(
            "Username already exists. Please choose another."));
      } else {
        final newUser = Students(
          id: studentBox.length + 1,
          studentName: event.username,
          mobileNo: event.mobileNumber,
          loginPassword: event.password,
        );
        await studentBox.add(newUser);
        emit(RegistrationSuccess());
      }
    });
  }
}
