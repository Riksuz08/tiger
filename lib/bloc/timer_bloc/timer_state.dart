part of 'timer_bloc.dart';

@immutable
abstract class TimerState {}

class TimerWithState extends TimerState {
  final bool opened;

  TimerWithState({required this.opened});
}
