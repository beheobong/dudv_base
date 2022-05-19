import 'package:flutter/material.dart';

mixin FormPresenter {
  List get keys;
  BuildContext get context;

  bool get valid {
    hideKeyBoard();
    bool _valid = true;
    for (var element in keys) {
      if (element.currentState != null &&
          !element.currentState.checkValidate()) {
        _valid = false;
      }
    }
    return _valid;
  }

  void resetValid() {
    for (var element in keys) {
      if (element.currentState != null) {
        element.currentState.resetValide();
      }
    }
  }

  void hideKeyBoard() => FocusScope.of(context).unfocus();
}
