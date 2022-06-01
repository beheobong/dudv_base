import 'package:flutter/foundation.dart';
import 'utils.dart';

mixin ApiPresenter {
  void showLoading();
  Future hideLoading();

  Map<String, Function> get apiSubmits;
  static ValueChanged<String>? _showError;
  static void setShowError(ValueChanged<String> value) {
    _showError = value;
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
        if (_showError != null) {
          _showError!(e.toString());
        } else {
          Utils.handleError(e);
        }
      }
      return null;
    }
  }
}
