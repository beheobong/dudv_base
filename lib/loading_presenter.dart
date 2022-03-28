import 'dart:io';

import 'package:dudv_base/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LoadingPresenter {
  bool _isShowDialog = false;

  BuildContext get context;

  static Widget? view;
  static void setLoadingView(Widget value, Color bgValue) {
    view = value;
    bg = bgValue;
  }

  static Color? bg;

  void showLoading({bool useRootNavigator = false}) {
    _isShowDialog = true;
    Utils.showModalDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      bg: bg,
      view: SizedBox(
          width: 100,
          height: 100,
          child: Center(
              child: view ??
                  (Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(
                          radius: 15,
                        )))),
    );
  }

  Future hideLoading() async {
    if (!_isShowDialog) return;
    return Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context).pop();
      _isShowDialog = false;
    });
  }
}
