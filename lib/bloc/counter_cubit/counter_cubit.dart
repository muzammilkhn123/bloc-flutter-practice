import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_practice_2/bloc/internet_cubit/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription internetSubscription;
  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetSubscription = internetCubit.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.MobileData) {
        decrement();
      }
    });
  }

  void increment() {
    emit(CounterState(counterValue: state.counterValue + 1, isIncrement: true));
  }

  void decrement() {
    emit(
        CounterState(counterValue: state.counterValue - 1, isIncrement: false));
  }

  @override
  Future<void> close() {
    internetSubscription.cancel();
    return super.close();
  }
}
