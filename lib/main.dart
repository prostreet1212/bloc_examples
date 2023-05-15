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
    CounterBloc counterBloc = CounterBloc();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(create: (context) => counterBloc),
          BlocProvider<UserBloc>(create: (context) => UserBloc(counterBloc)),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    //UserBloc userBloc = UserBloc();
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              counterBloc.add(CounterIncEvent());
            },
            icon: const Icon(Icons.plus_one),
          ),
          IconButton(
            onPressed: () {
              counterBloc.add(CounterDecEvent());
            },
            icon: const Icon(Icons.exposure_minus_1),
          ),
          IconButton(
            onPressed: () {
              userBloc.add(UserGetUsersEvent(counterBloc.state));
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              userBloc.add(UserGetJobsEvent(counterBloc.state));
            },
            icon: const Icon(Icons.work),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CounterBloc, int>(
                bloc: counterBloc,
                builder: (context, state) {
                  return Text(state.toString(), style: TextStyle(fontSize: 33));
                },
              ),
              BlocBuilder<UserBloc, UserState>(
                bloc: userBloc,
                builder: (context, state) {
                  final users = state.users;
                  final jobs = state.jobs;
                  return Column(
                    children: [
                      if (state.isLoading) const CircularProgressIndicator(),
                      if (users.isNotEmpty)
                        ...state.users.map((e) => Text(e.name)),
                      if (jobs.isNotEmpty)
                        ...state.jobs.map((e) => Text(e.name)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
