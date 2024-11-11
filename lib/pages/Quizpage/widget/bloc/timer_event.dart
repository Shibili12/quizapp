part of 'timer_bloc.dart';

abstract class TimerEvent {}

class StartTimer extends TimerEvent {}

class StopTimer extends TimerEvent {
  final int resetTime;
  StopTimer({required this.resetTime});
}

class Tick extends TimerEvent {}
class TimerFinished extends TimerEvent {}