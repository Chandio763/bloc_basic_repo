import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarty_editor_with_block/bloc/counter_bloc/counter_bloc.dart';
import 'package:smarty_editor_with_block/bloc/counter_bloc/counter_state.dart';

import '../bloc/counter_bloc/counter_event.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bloc Example')),
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            int counterValue = 0;
            if (state is CounterValue) {
              counterValue = state.value;
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Counter Value: $counterValue'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CounterBloc>(context).add(IncrementEvent());
                        },
                        child: Text('Increment'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CounterBloc>(context).add(DecrementEvent());
                        },
                        child: Text('Decrement'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}