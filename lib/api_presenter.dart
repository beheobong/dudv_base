import 'package:flutter/material.dart';
import 'utils.dart';

mixin ApiPresenter {
  void showLoading();
  Future hideLoading();
  BuildContext get context;

  Map<String, Function> get apiSubmits;
  static ValueChanged<String>? _showError;
  static Function(dynamic e, dynamic stack)? _catchError;

  static void setShowError(ValueChanged<String> value,
      {Function(dynamic e, dynamic stack)? catchError}) {
    _showError = value;
    _catchError = catchError;
  }

  Future onSubmit(String func,
      {String? msgSuc,
      bool loading = true,
      bool showError = true,
      bool logError = true}) async {
    if (loading) {
      showLoading();
    }
    try {
      final result = await apiSubmits[func]!();
      if (loading) {
        await hideLoading();
      }
      if (msgSuc != null) {
        // ignore: use_build_context_synchronously
        Utils.showToastCx(context, title: msgSuc);
      }
      return result;
    } catch (e, stack) {
      if (logError) {
        debugPrint('$e $stack');
        if (_catchError != null) {
          _catchError!(e, stack);
        }
      }
      if (loading) {
        await hideLoading();
      }
      if (showError) {
        if (_showError != null) {
          _showError!(e.toString());
        } else {
          // ignore: use_build_context_synchronously
          Utils.handleError(context, e);
        }
      }
      return null;
    }
  }
}
