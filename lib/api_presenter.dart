import 'dart:convert';

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
          final eValue = e.toString();
          if (eValue.contains('{')) {
            try {
              final _eJson = jsonDecode(eValue);
              if (_eJson is Map && _eJson.containsKey('message')) {
                Utils.showToast(_eJson['message']);
              } else {
                Utils.showToast(eValue);
              }
            } catch (e1, stack1) {
              debugPrint('$e1 $stack1');
              Utils.showToast(eValue);
            }
          } else {
            Utils.showToast(eValue);
          }
        }
      }
      return null;
    }
  }
}
