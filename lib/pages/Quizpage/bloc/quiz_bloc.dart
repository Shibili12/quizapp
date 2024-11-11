import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:quizapp/controller/quetationrepository.dart';
import 'package:quizapp/db/answers_model.dart';
import 'package:quizapp/db/choice_model.dart';
import 'package:quizapp/db/question_model.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final HiveQuestionRepository questionRepository;
  final int studentId; // Keep track of the student ID

  QuizBloc({required this.questionRepository, required this.studentId})
      : super(QuizState(
            questions: [],
            questionChoices: {},
            answers: {},
            hasReachedEnd: false)) {
    on<LoadQuestions>(_onLoadQuestions);
    on<SubmitAnswer>(_onSubmitAnswer);
  }

  void _onLoadQuestions(LoadQuestions event, Emitter<QuizState> emit) async {
    if (state.hasReachedEnd) return;

    final answeredBox = Hive.box<Answers>('answersBox');
    final answeredQuestionIds = answeredBox.values
        .where((answer) => answer.studentId == studentId)
        .map((answer) => answer.questionId)
        .toSet();

    // Fetch unanswered questions
    final newQuestions =
        await questionRepository.getQuestions(state.questions.length);
    final unansweredQuestions =
        newQuestions.where((q) => !answeredQuestionIds.contains(q.id)).toList();

    final Map<int, List<Choice>> newQuestionChoices = {};
    for (var question in unansweredQuestions) {
      final choices =
          await questionRepository.getChoicesForQuestion(question.id);
      newQuestionChoices[question.id] = choices;
    }

    emit(state.copyWith(
      questions: List.from(state.questions)..addAll(unansweredQuestions),
      questionChoices: Map.from(state.questionChoices)
        ..addAll(newQuestionChoices),
      hasReachedEnd: unansweredQuestions.isEmpty,
    ));
  }

  void _onSubmitAnswer(SubmitAnswer event, Emitter<QuizState> emit) async {
    final updatedAnswers = Map<int, int>.from(state.answers)
      ..[event.questionId] = event.choiceId;

    final answersBox = Hive.box<Answers>('answersBox');
    if (event.questionId != -1 && event.choiceId != -1) {
      final newAnswer = Answers(
        id: answersBox.length + 1,
        studentId: event.studentid,
        questionId: event.questionId,
        choicesId: event.choiceId,
      );
      await answersBox.add(newAnswer);
    }

    emit(state.copyWith(answers: updatedAnswers));

    // Check if 50 questions have been answered
    if (updatedAnswers.length >= 50) {
      await Hive.box<Question>('questionsBox').clear();
      await Hive.box<Choice>('choicesBox').clear();

      emit(QuizCompleted());
    } else {
      add(LoadQuestions());
    }
  }
}
