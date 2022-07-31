//actions ou events
import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

//state
abstract class CounterState {
  final int counter;
  const CounterState(
      {
        required this.counter
      }
      );
}
class CounterSuccessState extends CounterState{
  CounterSuccessState({required int counter}): super(counter: counter);
}
class CounterErrorState extends CounterState{
  final String errorMessage;
  CounterErrorState({required int counter,
    required this.errorMessage}): super(counter: counter);
}


class CounterInitialState extends CounterState{
  CounterInitialState(): super(counter: 0);
}

//Bloc
class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc(): super(CounterInitialState()){
      on((IncrementCounterEvent event,emit){
        //dans le state on a un objet qui s'appele state
          if(state.counter<10){
            int counterValue=state.counter+1;
            emit(CounterSuccessState(counter: counterValue));
          }else{
            emit(CounterErrorState(
              counter: state.counter,
              errorMessage: "Counter value can not exceed 10"
            ));
          }
      });
      on((DecrementCounterEvent event,emit){
        if(state.counter>0){
          int counterValue=state.counter-1;
          emit(CounterSuccessState(counter: counterValue));
        }else{
          emit(CounterErrorState(
              counter: state.counter,
              errorMessage: "Counter value can't be less than 0"
          ));
        }
      });
  }
}



