part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  @override
  List<Object> get props => [];
}

class LoadQuestions extends QuizEvent {}

class SubmitAnswer extends QuizEvent {
  final int questionId;
  final int choiceId;
  final int studentid;

  const SubmitAnswer(this.questionId, this.choiceId,this.studentid);

  @override
  List<Object> get props => [questionId, choiceId,studentid];
}


