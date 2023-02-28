import 'package:dudv_base/dudv_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  LoadingView.color(Colors.yellow);
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: StateNotifierProvider<MyAppPresenter, Count>(
          create: (context) => MyAppPresenter(context), child: const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff213245),
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            const LoadingView(),
            Text(
              'Running on: ${context.watch<Count>().value}\n',
              style: Styles.copyStyle(),
            ),
            BtnView(
                onPress: context.read<MyAppPresenter>().onLogin, title: 'Login')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<MyAppPresenter>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyAppPresenter extends StateNotifier<Count>
    with LocatorMixin, ApiPresenter, LoadingPresenter {
  MyAppPresenter(this.context) : super(Count(0));
  @override
  final BuildContext context;
  final String _loginFuncKey = 'login_func_key';

  void increment() {
    state = Count(state.value + 1);
  }

  void decrement() {
    state = Count(state.value - 1);
  }

  void onLogin() async {
    final res = await onSubmit(_loginFuncKey);
    if (kDebugMode) {
      print(res);
    }
  }

  Future _login() => Future.value(true);

  @override
  Map<String, Function> get apiSubmits => {_loginFuncKey: _login};
}

class Count {
  int value;

  Count(this.value);
}
