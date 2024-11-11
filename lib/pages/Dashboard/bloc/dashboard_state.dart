part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalQuestions;
  final int answeredQuestions;
  final int unansweredQuestions;
  final int correctAnswers;
  final int wrongAnswers;

  DashboardLoaded({
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.unansweredQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  List<Object> get props => [
        totalQuestions,
        answeredQuestions,
        unansweredQuestions,
        correctAnswers,
        wrongAnswers,
      ];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
