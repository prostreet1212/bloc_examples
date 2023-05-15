import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../counter_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocDescription;

  UserBloc(this.counterBloc) : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetJobsEvent>(_onGetJob);
    counterBlocDescription = counterBloc.stream.listen((state) {
      if (state <= 0) {
        add(UserGetUsersEvent(0));
        add(UserGetJobsEvent(0));
      }
    });
  }

  @override
  Future<void> close() async {
    counterBlocDescription.cancel();
    return super.close();
  }

  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final users = List.generate(
        event.count, (index) => User(name: 'dimka', id: index.toString()));
    emit(state.copyWith(users: users));
  }

  _onGetJob(UserGetJobsEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    final jobs = List.generate(
        event.count, (index) => User(name: 'job', id: index.toString()));
    emit(state.copyWith(jobs: jobs));
  }
}
