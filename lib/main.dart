import 'package:bloc_examples/counter_bloc.dart';
import 'package:bloc_examples/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc bloc = CounterBloc();
    UserBloc userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
      ],
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                bloc.add(CounterIncEvent());
              },
              icon: const Icon(Icons.plus_one),
            ),
            IconButton(
              onPressed: () {
                bloc.add(CounterDecEvent());
              },
              icon: const Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                BlocBuilder<CounterBloc,int>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Text(state.toString(), style: TextStyle(fontSize: 33));
                  },
                ),
                BlocBuilder<UserBloc,UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    return Text(state.toString(), style: TextStyle(fontSize: 33));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
