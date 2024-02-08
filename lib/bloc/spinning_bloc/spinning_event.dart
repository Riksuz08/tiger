part of 'spinning_bloc.dart';

@immutable
abstract class SpinningEvent {}

class isSpinningEvent extends SpinningEvent {
  final bool isSpinning;

  isSpinningEvent({
    required this.isSpinning,
  });
}
