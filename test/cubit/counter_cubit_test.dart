// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_bloc_practice_2/bloc/counter_cubit/counter_cubit.dart';
// import 'package:test/test.dart';

// void main() {
//   group("Counter Cubit Tests", () {
//     CounterCubit counterCubit;

//     setUp(() {
//       counterCubit = CounterCubit();
//     });
//     tearDown(() {
//       counterCubit.close();
//     });

//     blocTest("increment function test",
//         build: () => counterCubit,
//         act: (cubit) => counterCubit.increment(),
//         expect: [CounterState(counterValue: 1, isIncrement: true)]);
//     blocTest("decrement function test",
//         build: () => counterCubit,
//         act: (cubit) => counterCubit.decrement(),
//         expect: [CounterState(counterValue: -1, isIncrement: false)]);
//   });
// }
