import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncEvent>(_onIncrement);
    on<CounterDecEvent>(_onDecrement);
  }

  _onIncrement(CounterIncEvent event, Emitter<int> emit){
    emit(state+1);
  }
  _onDecrement(CounterDecEvent event, Emitter<int> emit){
    if(state<=0)return;
    emit(state-1);
  }
}

abstract class CounterEvent {}

class CounterIncEvent extends CounterEvent {}

class CounterDecEvent extends CounterEvent {}
