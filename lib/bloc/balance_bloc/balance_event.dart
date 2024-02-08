part of 'balance_bloc.dart';

@immutable
abstract class BalanceEvent {}

class SpinEvent extends BalanceEvent {
  final int balance;
  final int win;

  SpinEvent(this.balance, this.win);
}
