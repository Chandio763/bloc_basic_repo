import 'package:bloc/bloc.dart';
import 'package:smarty_editor_with_block/bloc/counter_bloc/counter_state.dart';
import 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>((event, emit) {
      // Handle increment event
      if (state is CounterValue) {
        emit(CounterValue((state as CounterValue).value + 1));
      } else {
        emit(CounterValue(1));
      }
    });

    on<DecrementEvent>((event, emit) {
      // Handle decrement event
      if (state is CounterValue) {
        emit(CounterValue((state as CounterValue).value - 1));
      } else {
        emit(CounterValue(-1));
      }
    });
  }}