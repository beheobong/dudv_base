import 'package:flutter/material.dart';
import 'config.dart';
import 'utils.dart';

mixin ApiPresenter {
  void showLoading();
  Future hideLoading();
  BuildContext get context;

  Map<String, Function> get apiSubmits;

  Future onSubmit(
    String func, {
    String? msgSuc,
    bool loading = true,
    bool showError = true,
  }) async {
    if (loading) {
      showLoading();
    }
    try {
      final result = await apiSubmits[func]!();
      if (loading) {
        await hideLoading();
      }
      if (msgSuc != null && context.mounted) {
        Utils.showToastCx(context, title: msgSuc);
      }
      return result;
    } catch (e, stack) {
      if (loading) {
        await hideLoading();
      }
      if (DudvConfig.catchError != null && context.mounted) {
        DudvConfig.catchError!(context, e, stack);
      }
      debugPrint('$e $stack');
      if (showError) {
        if (DudvConfig.showError != null) {
          DudvConfig.showError!(e.toString());
        }
      }

      return null;
    }
  }
}
