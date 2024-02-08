part of 'spinning_bloc.dart';

@immutable
abstract class SpinningState {}

class isSpinningState extends SpinningState {
  final bool isSpinning;

  isSpinningState({
    required this.isSpinning,
  });
}
