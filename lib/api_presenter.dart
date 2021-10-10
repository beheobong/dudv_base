import 'package:flutter/material.dart';
import 'utils.dart';

mixin ApiPresenter {
  Map<String, Function> get apiSubmits;
  void showLoading();
  Future hideLoading();

  Future onSubmit(String func, {String? msgSuc}) async {
    showLoading();
    try {
      final result = await apiSubmits[func]!();
      await hideLoading();
      if (msgSuc != null) {
        Utils.showToast(msgSuc);
      }
      return result;
    } catch (e, stack) {
      debugPrint('$e $stack');
      await hideLoading();
      Utils.showToast(e.toString());
      return null;
    }
  }
}
