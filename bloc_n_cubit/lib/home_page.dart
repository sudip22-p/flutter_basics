import "package:bloc_n_cubit/add_sub.dart";
import "package:bloc_n_cubit/bloc/counter_bloc.dart";
// import "package:bloc_n_cubit/cubit/counter_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // final counterCubit = BlocProvider.of<CounterCubit>(context);
    // final counterBloc = BlocProvider.of<CounterBloc>(context); //no needed any of this as these are already provided form BlocProviders
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            // BlocBuilder<CounterCubit, int>(
            // bloc: counterCubit,
            BlocBuilder<CounterBloc, int>(
              // bloc: counterBloc, //not compulsory for both bloc and cubit ...
              builder: (context, counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddSubPage(),
            ),
          );
        },
        tooltip: 'Decrement',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
