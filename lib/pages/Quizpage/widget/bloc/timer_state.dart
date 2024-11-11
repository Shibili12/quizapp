part of 'timer_bloc.dart';

class TimerState {
  final int timeRemaining;
  TimerState({required this.timeRemaining});
}

final class TimerInitial extends TimerState {
  TimerInitial({required super.timeRemaining});
}
