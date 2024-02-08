part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}

class TimerWithEvent extends TimerEvent {
  final bool opened;

  TimerWithEvent({required this.opened});
}
