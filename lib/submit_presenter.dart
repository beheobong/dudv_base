import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contract.dart';
import 'utils.dart';

mixin SubmitPresenter {
  bool _isShowDialog = false;
  BuildContext get context;
  Contract get view;
  List<Future> get apiSubmits;

  Future onSubmit({String messageSuccess, int index = 0}) async {
    showLoading();
    try {
      final result = await apiSubmits[index];
      await hideLoading();
      if (messageSuccess != null) {
        Utils.showToast(messageSuccess);
      }
      return result;
    } catch (e, stack) {
      debugPrint('$e $stack');
      await hideLoading();
      Utils.showToast(e.message);
      return null;
    }
  }

  void showLoading() {
    _isShowDialog = true;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(
                          radius: 15,
                        ))),
        );
      },
    );
  }

  Future hideLoading() async {
    if (!_isShowDialog) return;
    if (Navigator.of(context).canPop()) {
      return Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pop();
        _isShowDialog = false;
      });
    }
  }
}
