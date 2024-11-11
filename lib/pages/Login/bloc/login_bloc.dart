import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:quizapp/db/login_model.dart';
import 'package:quizapp/db/students_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final studentBox = Hive.box<Students>('studentsBox');
      final loginBox = Hive.box<LoginModel>('loginBox');

      try {
        // Attempt to find the user in the studentBox
        final studentUser = studentBox.values.firstWhere(
          (student) =>
              student.studentName == event.username &&
              student.loginPassword == event.password,
        );

        // If found, add user to loginBox
        final loginUser = LoginModel(
          id: studentUser.id, // Auto-increment id
          loginId: studentUser.studentName,
          password: studentUser.loginPassword,
          isAdmin: false, // or true if applicable
        );

        await loginBox.add(loginUser);

        emit(LoginSuccess(loginUser));
      } on StateError {
        // Handle case where no matching user is found
        emit(LoginFailure("Invalid username or password."));
      } catch (e) {
        emit(LoginFailure("An error occurred during login."));
      }
    });

    on<LogoutUser>((event, emit) async {
      final loginBox = Hive.box<LoginModel>('loginBox');
      await loginBox.clear();
      emit(LoginInitial());
    });
  }
}
