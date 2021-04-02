import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice_2/bloc/counter_cubit/counter_cubit.dart';
import 'package:flutter_bloc_practice_2/bloc/internet_cubit/internet_cubit.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                print(state);
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text("WIFI");
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.MobileData) {
                  return Text("MOBILE DATA");
                } else if (state is InternetDisconnected) {
                  return Text("Disconnected");
                } else {
                  return CircularProgressIndicator();
                }
              }),
              Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (cntxt, state) {
                  print(state.isIncrement);
                  if (state.isIncrement) {
                    Scaffold.of(cntxt).showSnackBar(SnackBar(
                        content: Text("Incremented!"),
                        duration: Duration(milliseconds: 300)));
                  } else {
                    Scaffold.of(cntxt).showSnackBar(SnackBar(
                        content: Text("Decremented!"),
                        duration: Duration(milliseconds: 300)));
                  }
                },
                listenWhen: (previousState, currentState) {
                  if (currentState.counterValue > 0) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
                buildWhen: (previous, current) {
                  bool returnValue = false;
                  if (current.counterValue >= 0) {
                    returnValue = true;
                  }
                  return returnValue;
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                GestureDetector(
                    onTap: () =>
                        BlocProvider.of<CounterCubit>(context).increment(),
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.add))),
                GestureDetector(
                    onTap: () =>
                        BlocProvider.of<CounterCubit>(context).decrement(),
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.remove)))
              ]),
              SizedBox(height: 40),
              MaterialButton(
                  color: Colors.blue,
                  child: Text("Goto Second Screen"),
                  onPressed: () => Navigator.of(context).pushNamed("/second"))
            ])));
  }
}
