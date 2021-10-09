import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'contract.dart';
import 'utils.dart';

mixin SubmitPresenter {
  BuildContext get context;
  Contract get view;
  List<Function> get apiSubmits;
  void showLoading();
  Future hideLoading();
  Logger get logger;

  Future onSubmit({String? messageSuccess, int index = 0}) async {
    showLoading();
    try {
      final result = await apiSubmits[index]();
      await hideLoading();
      if (messageSuccess != null) {
        Utils.showToast(messageSuccess);
      }
      return result;
    } catch (e, stack) {
      logger.e('$e $stack');
      await hideLoading();
      Utils.showToast(e.toString());
      return null;
    }
  }

 
}
