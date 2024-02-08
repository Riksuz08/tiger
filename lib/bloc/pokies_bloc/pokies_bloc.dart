import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pokies_event.dart';
part 'pokies_state.dart';

class PokiesBloc extends Bloc<PokiesEvent, PokiesState> {
  PokiesBloc() : super(SpinningTrueState(isSpinning: false)) {
    on<SpinningTrueEvent>(_spinning);
  }

  void _spinning(SpinningTrueEvent event, Emitter<PokiesState> emit) {
    bool isSpinning = event.isSpinning;

    emit(SpinningTrueState(
      isSpinning: isSpinning,
    ));
  }
}
