part of 'pokies_bloc.dart';

@immutable
abstract class PokiesEvent {}

class SpinningTrueEvent extends PokiesEvent {
  final bool isSpinning;

  SpinningTrueEvent({
    required this.isSpinning,
  });
}
