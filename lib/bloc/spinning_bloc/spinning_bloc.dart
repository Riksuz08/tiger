import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'spinning_event.dart';
part 'spinning_state.dart';

class SpinningBloc extends Bloc<SpinningEvent, SpinningState> {
  SpinningBloc() : super(isSpinningState(isSpinning: false)) {
    on<isSpinningEvent>(_isSpinning);
  }

  void _isSpinning(isSpinningEvent event, Emitter<SpinningState> emit) {
    bool isSpinning = event.isSpinning;

    emit(isSpinningState(
      isSpinning: isSpinning,
    ));
  }
}
