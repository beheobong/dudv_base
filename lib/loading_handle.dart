import 'dart:io';

import 'package:dudv_base/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingHandle {
  bool _isShowDialog = false;

  void showLoading(BuildContext context, {bool useRootNavigator = false}) {
    _isShowDialog = true;
    Utils.showModalDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      view: SizedBox(
          width: 100,
          height: 100,
          child: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator()
                  : const CupertinoActivityIndicator(
                      radius: 15,
                    ))),
    );
  }

  Future hideLoading(BuildContext context) async {
    if (!_isShowDialog) return;
    if (Navigator.of(context).canPop()) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pop();
        _isShowDialog = false;
      });
    }
  }
}
