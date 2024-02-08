import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
part 'balance_event.dart';
part 'balance_state.dart';

@Injectable()
class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial()) {
    on<SpinEvent>(_balance);
  }

  void _balance(SpinEvent event, Emitter<BalanceState> emit) {
    int balanceValue = event.balance;

    int winValue = event.win;

    emit(BalanceSpinState(balanceValue, winValue));
  }
}
