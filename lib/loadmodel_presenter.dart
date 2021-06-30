import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contract.dart';

mixin LoadModelPresenter {
  BuildContext get context;
  Contract get view;
  Future apiGet();
  Future showMessage({String content});

  Future onGet() async {
    try {
      final result = await apiGet();
      return result;
    } catch (e, stack) {
      debugPrint('$e $stack');
      showMessage(content: e.message);
      // Utils.showToast(e.message);
      return null;
    }
  }


}
