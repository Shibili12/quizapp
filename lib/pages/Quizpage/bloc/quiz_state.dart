part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final List<Question> questions;
  final Map<int, List<Choice>> questionChoices; // Map of questionId -> choices
  final Map<int, int> answers; // questionId -> choiceId map
  final bool hasReachedEnd;

  const QuizState({
    required this.questions,
    required this.questionChoices,
    required this.answers,
    required this.hasReachedEnd,
  });

  QuizState copyWith({
    List<Question>? questions,
    Map<int, List<Choice>>? questionChoices,
    Map<int, int>? answers,
    bool? hasReachedEnd,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      questionChoices: questionChoices ?? this.questionChoices,
      answers: answers ?? this.answers,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props =>
      [questions, questionChoices, answers, hasReachedEnd];
}

class QuizCompleted extends QuizState {
  QuizCompleted()
      : super(
          questions: [],
          questionChoices: {},
          answers: {},
          hasReachedEnd: true,
        );
}
