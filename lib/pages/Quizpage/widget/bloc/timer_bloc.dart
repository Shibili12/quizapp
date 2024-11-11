import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  int _timeRemaining;

  TimerBloc(int initialTime)
      : _timeRemaining = initialTime,
        super(TimerState(timeRemaining: initialTime)) {
    on<StartTimer>((event, emit) {
      _startTimer();
    });
    on<StopTimer>((event, emit) {
      _stopTimer();
      _timeRemaining = event.resetTime;
      emit(TimerState(timeRemaining: _timeRemaining));
    });
    on<Tick>((event, emit) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        emit(TimerState(timeRemaining: _timeRemaining));
      }
      if (_timeRemaining <= 0) {
        add(TimerFinished());
      }
    });
    on<TimerFinished>((event, emit) {
      _stopTimer();
      emit(TimerState(timeRemaining: 0));
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(Tick());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
