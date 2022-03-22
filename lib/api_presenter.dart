import 'package:flutter/foundation.dart';
import 'utils.dart';

mixin ApiPresenter {
  Map<String, Function> get apiSubmits;
  void showLoading();
  Future hideLoading();
  static ValueChanged<String>? _showError;
  static void setShowError(ValueChanged<String> value) {
    _showError = value;
  }

  Future onSubmit(String func,
      {String? msgSuc,
      bool loading = true,
      bool showError = true,
      bool logError = true,
      AsyncValueSetter? handle}) async {
    if (loading) {
      showLoading();
    }
    try {
      final result = await apiSubmits[func]!();
      if (handle != null) {
        await handle(result);
      }
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
          Utils.showToast(e.toString());
        }
      }
      return null;
    }
  }
}
