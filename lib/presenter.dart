import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

mixin Presenter {
  BuildContext get context;

  Future onRefresh() {
    loadData();
    return Future.value(true);
  }

  Future loadData() {
    return Future.value(true);
  }

  void hideKeyBoard() {
    FocusScope.of(context).unfocus();
  }

  void onBack({value}) {
    Navigator.of(context).pop(value);
  }

  Widget loadingView2({Brightness? brightness}) {
    final iosWidget = Theme(
      data: ThemeData(
        cupertinoOverrideTheme:
            CupertinoThemeData(brightness: brightness ?? Brightness.dark),
      ),
      child: const CupertinoActivityIndicator(radius: 15),
    );

    const androidWidget = SizedBox(
      width: 30,
      height: 30,
      child: FittedBox(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );

    return Center(
      child: Utils.isAndroid ? androidWidget : iosWidget,
    );
  }
}
