import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice_2/bloc/counter_cubit/counter_cubit.dart';
import 'package:flutter_bloc_practice_2/bloc/internet_cubit/internet_cubit.dart';

import 'package:flutter_bloc_practice_2/routes/app_routes.dart';

void main() {
  runApp(MyApp(appRoutes: AppRoutes(), connectivity: Connectivity()));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  final AppRoutes appRoutes;
  const MyApp({Key key, @required this.appRoutes, @required this.connectivity});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (_) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(
            create: (__) =>
                CounterCubit(internetCubit: BlocProvider.of<InternetCubit>(__)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRoutes.onGenerateRoute,
      ),
    );
  }
}
