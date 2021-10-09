import 'dart:async';
import 'dart:io';
import 'package:dudv_base/loading_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contract.dart';

abstract class Presenter {
  Presenter(
    this.context,
    this.view,
  ) {
    init();
  }

  final Contract view;
  final BuildContext context;
  List list = [];
  bool isFirst = true;
  final LoadingHandle loading = LoadingHandle();

  Future onRefresh() {
    loadData();
    return Future.value(true);
  }

  void handleError(e, stack) {}

  void init() {}

  Future loadData() {
    isFirst = false;
    return Future.value(true);
  }

  Future dispose() async {
    return Future.value(true);
  }

  void hideKeyBoard() {
    FocusScope.of(context).unfocus();
  }

  void onBack({value}) {
    Navigator.of(context).pop(value);
  }

  void showLoading() {
    return loading.showLoading(context);
  }

  Future hideLoading() {
    return loading.hideLoading(context);
  }

  Widget loadingView2({Brightness? brightness}) {
    final iosWidget = Theme(
      data: ThemeData(
        cupertinoOverrideTheme:
            CupertinoThemeData(brightness: brightness ?? Brightness.dark),
      ),
      child: CupertinoActivityIndicator(radius: 15),
    );

    final androidWidget = SizedBox(
      width: 30,
      height: 30,
      child: FittedBox(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );

    return Center(
      child: Platform.isAndroid ? androidWidget : iosWidget,
    );
  }

}
