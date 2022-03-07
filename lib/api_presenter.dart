import 'package:flutter/material.dart';
import 'utils.dart';

mixin ApiPresenter {
  Map<String, Function> get apiSubmits;
  void showLoading();
  Future hideLoading();

  Future onSubmit(
    String func, {
    String? msgSuc,
    bool loading = true,
    bool showError = true,
    bool logError = true,
  }) async {
    if (loading) {
      showLoading();
    }
    try {
      final result = await apiSubmits[func]!();
      if (loading) {
        await hideLoading();
      }
      if (msgSuc != null) {
        Utils.showToast(msgSuc);
      }
      return result;
    } catch (e, stack) {
      if (logError) {
        debugPrint('$e $stack');
      }
      if (loading) {
        await hideLoading();
      }
      if (showError) {
        Utils.showToast(e.toString());
      }
      return null;
    }
  }
}
