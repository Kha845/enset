import 'package:enset/ui/themes/themes.dart';
import 'package:enset/ui/widgets/main.drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("counter bloc"),
      ),
      body: Center(child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterSuccessState || state is CounterInitialState) {
            return Text("Counter value => ${state.counter}",
                style: Theme.of(context).textTheme.headline5);
          } else if (state is CounterErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Counter value => ${state.counter}",
                    style:
                    CustomThemes.errorTextStyle
          ),
                Text("Counter value => state.errorMessage",
                    style:
                   CustomThemes.errorTextStyle)
              ],
            );
          } else {
            return Container();
          }
        },
      )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag:"dec",
            onPressed:(){
              context.read<CounterBloc>().add(DecrementCounterEvent());
          },
            child: const Icon(Icons.remove),),
          const SizedBox(width: 6,),
          FloatingActionButton(
            heroTag:"inc",
            onPressed:(){
              context.read<CounterBloc>().add(IncrementCounterEvent());
          },
            child: const Icon(Icons.add),),
        ],
      ),
    );
  }
}
