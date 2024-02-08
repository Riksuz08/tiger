part of 'balance_bloc.dart';

@immutable
abstract class BalanceState {}

class BalanceInitial extends BalanceState {}

class BalanceSpinState extends BalanceState {
  final int balance;
  final int win;

  BalanceSpinState(this.balance, this.win);
}
