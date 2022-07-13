import 'package:dudv_base/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config.dart';

mixin LoadingPresenter {
  bool _isShowDialog = false;

  static Color? _color;

  static void color(Color color) {
    _color = color;
  }

  BuildContext get context;
  BuildContext? _ctx;

  void showLoading({bool useRootNavigator = false}) {
    _isShowDialog = true;
    Utils.showModalDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      bg: DudvConfig.bgLoadingValue,
      ctx: (mContext) {
        _ctx = mContext;
      },
      view: SizedBox(
          width: 100,
          height: 100,
          child: Center(
              child: DudvConfig.loadingView ??
                  (Utils.isAndroid
                      ? CircularProgressIndicator(
                          color: _color,
                        )
                      : CupertinoActivityIndicator(
                          radius: 15,
                          color: _color,
                        )))),
    );
  }

  Future hideLoading() async {
    try {
      if (!_isShowDialog || _ctx == null) return;
      return Future.delayed(const Duration(milliseconds: 300), () {
        if (Navigator.of(_ctx!).canPop()) {
          Navigator.of(_ctx!).pop();
        }
        _isShowDialog = false;
      });
    } catch (e, stack) {
      debugPrint('$e $stack');
    }
  }
}
