import 'package:dudv_base/dudv_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StateNotifierProvider<MyAppPresenter, Count>(
          create: (context) => MyAppPresenter(context), child: MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text('Running on: ${context.watch<Count>().value}\n'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<MyAppPresenter>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyAppPresenter extends StateNotifier<Count> with LocatorMixin, LoadingPresenter {
  MyAppPresenter(this.context) : super(Count(0));
  final BuildContext context;

  void increment() {
    state = Count(state.value + 1);
  }

  void decrement() {
    state = Count(state.value - 1);
  }
}

class Count {
  int value;

  Count(this.value);
}
