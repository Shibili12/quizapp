import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:quizapp/db/answers_model.dart';
import 'package:quizapp/db/question_model.dart';
import 'package:quizapp/db/students_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>((event, emit) async {
      emit(DashboardLoading());
      try {
        final studentBox = Hive.box<Students>('studentsBox');
        final questionBox = Hive.box<Question>('questionsBox');
        final answerBox = Hive.box<Answers>('answersBox');

        // Fetch total questions
        int totalQuestions = questionBox.length;

        // Initialize counters
        int answeredQuestions = 0;
        int correctAnswers = 0;
        int wrongAnswers = 0;

        // Assume current student ID is at index 0 for example
        final currentStudentId = studentBox.getAt(0)?.id;

        for (var answer in answerBox.values) {
          if (answer.studentId == currentStudentId) {
            answeredQuestions++;

            // Find the corresponding question for this answer
            final question = questionBox.get(answer.questionId);

            if (question != null) {
              // Calculate correct answer ID for this question
              final correctAnswerChoiceId =
                  question.id * 10 + question.answerChoicesID;

              // Check if user's answer matches the correct answer ID
              if (answer.choicesId == correctAnswerChoiceId) {
                correctAnswers++;
              } else {
                wrongAnswers++;
              }
            }
          }
        }

        int unansweredQuestions = totalQuestions - answeredQuestions;

        emit(DashboardLoaded(
          totalQuestions: totalQuestions,
          answeredQuestions: answeredQuestions,
          unansweredQuestions: unansweredQuestions,
          correctAnswers: correctAnswers,
          wrongAnswers: wrongAnswers,
        ));
      } catch (e) {
        emit(DashboardError("Failed to load dashboard data: $e"));
      }
    });
  }
}
