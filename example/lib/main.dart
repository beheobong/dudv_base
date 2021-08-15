import 'package:dudv_base/contract.dart';
import 'package:dudv_base/presenter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements Contract {
  MyAppPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = MyAppPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: ${_presenter.platformVersion}\n'),
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}

class MyAppPresenter extends Presenter {
  MyAppPresenter(BuildContext context, Contract view) : super(context, view);

  String platformVersion = 'Unknown';

  @override
  void init() {
    super.init();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initPlatformState();
    });
  }

  void initPlatformState() {
    platformVersion = '0.0.1';
    view.updateState();
  }
}
