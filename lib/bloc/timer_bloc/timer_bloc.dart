import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerWithState(opened: true)) {
    on<TimerWithEvent>(_timer);
  }

  void _timer(TimerWithEvent event, Emitter<TimerState> emit) {
    bool open = event.opened;

    emit(TimerWithState(opened: open));
  }
}
