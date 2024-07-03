abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterValue extends CounterState {
  final int value;
  CounterValue(this.value);
}