import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contract.dart';

mixin LoadModelPresenter {
  BuildContext get context;
  Contract get view;
  late List<Function> apiGets;
  Future showMessage({String content});

  Future onGet({int index = 0}) async {
    try {
      final result = await apiGets[index]();
      return result;
    } catch (e, stack) {
      debugPrint('$e $stack');
      showMessage(content: e.toString());
      return null;
    }
  }


}
