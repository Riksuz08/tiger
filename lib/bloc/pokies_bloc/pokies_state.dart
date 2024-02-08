part of 'pokies_bloc.dart';

@immutable
abstract class PokiesState {}

class SpinningTrueState extends PokiesState {
  final bool isSpinning;

  SpinningTrueState({
    required this.isSpinning,
  });
}
