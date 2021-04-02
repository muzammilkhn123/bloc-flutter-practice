import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice_2/bloc/counter_cubit/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
              ])
            ])));
  }
}
