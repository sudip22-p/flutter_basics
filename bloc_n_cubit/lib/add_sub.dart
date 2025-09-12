import 'package:bloc_n_cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubPage extends StatefulWidget {
  const AddSubPage({super.key});

  @override
  State<AddSubPage> createState() => _AddSubPageState();
}

class _AddSubPageState extends State<AddSubPage> {
  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Add Sub Page"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: counterCubit.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: counterCubit.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
