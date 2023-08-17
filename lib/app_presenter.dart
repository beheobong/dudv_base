import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_contract.dart';
import 'utils.dart';
import 'view/no_data_view.dart';

abstract class AppPresenter {
  AppPresenter(this.context, this.view, {this.isLoadMore = true}) {
    _init();
    init();
  }

  final BuildContext context;
  final AppContract view;

  List list = [];

  bool isFirst = true;

  // sử dụng scrollController các scrollview
  //và thuộc tính loadmore = false nếu ko dùng loadmore
  final bool isLoadMore;
  final controller = ScrollController();

  bool _showLoading = false;
  String textError = '';
  late final NavigatorState _navigator = Navigator.of(context);

  void _init() async {
    controller.addListener(_listener);
  }

  void _listener() {
    ScrollPosition position = controller.position;
    if (isLoadMore) {
      double maxScroll = position.maxScrollExtent;
      if (controller.offset >= maxScroll && !controller.position.outOfRange) {
        loadMore();
      }
    }
    if (position.userScrollDirection == ScrollDirection.reverse) {
      hideAppBar();
    }
    if (position.userScrollDirection == ScrollDirection.forward) {
      showAppBar();
    }
  }

  void hanldeError(Exception e, {bool showToast = false}) async {
    try {
      String message = e.toString();
      if (showToast) {
        Utils.showToast(message);
      } else {
        textError = message;
        view.updateState();
      }
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
  }

  void showAppBar() {}

  void hideAppBar() {}

  void init() {}

  void loadData() {
    isFirst = false;
  }

  void loadMore() {}

  Future onRefresh() {
    isFirst = true;
    view.updateState();
    loadData();
    return Future.value(true);
  }

  void dispose() {
    if (controller.hasClients) {
      try {
        controller.removeListener(_listener);
      } catch (e, stack) {
        debugPrint('AppPresenter---removeListener---controller $e $stack');
      }
      try {
        controller.dispose();
      } catch (e, stack) {
        debugPrint('AppPresenter---dispose---controller $e $stack');
      }
    }
  }

  void deactivate() {}

  void hideKeyboard() {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void hideKeyboard1() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void showKeyBoard(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  Future onBack() {
    hideKeyboard();
    return Navigator.of(context).maybePop();
  }

  void onDone() {}

  void scrollToTop() {
    if (controller.offset == 0.0) {
      // double heigh = MediaQuery.of(context).size.height;
      // controller.jumpTo(-heigh);
      showLoadingPage();
    } else {
      controller.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  void showLoadingPage() {}

  void scrollToEnd() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void onTextChanged(String value) {
    if (textError.isNotEmpty) {
      textError = '';
      view.updateState();
    }
  }

  void showLoading() {
    _showLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext ctx) {
        return Dialog(
          elevation: 10.0,
          backgroundColor: Colors.black.withOpacity(0.8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SizedBox(
            width: 104,
            height: 104,
            child: Container(
              width: 104,
              height: 104,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Future hideLoading() async {
    if (!_showLoading) return;
    if (Navigator.of(context).canPop()) {
      await Future.delayed(const Duration(milliseconds: 300), () {});
      if (_navigator.mounted) {
        await Navigator.of(context).maybePop();
      }
    }
    _showLoading = false;
  }

  // 3
  Widget loadingView({double? size}) {
    return SizedBox(
      width: size ?? double.infinity,
      height: size ?? 100,
      child: Center(
          child: Utils.isAndroid
              ? const CircularProgressIndicator()
              : const CupertinoActivityIndicator(radius: 15)),
    );
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

  Widget noDataView({
    bool isListView = false,
    String? title,
    double? size,
    Widget? child,
  }) {
    var noDataView = NoDataView(
      title: title,
      isListView: isListView,
      size: size,
    );
    if (child != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [child, noDataView],
      );
    }

    return noDataView;
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (isFirst && list.isEmpty) {
      return loadingView();
    } else {
      if (list.isEmpty) {
        return noDataView(isListView: false);
      } else {
        return itemBuild(context, index);
      }
    }
  }

  Widget itemBuild(BuildContext context, int index) {
    return const SizedBox.shrink();
  }

  void resetData() {
    isFirst = true;
    list.clear();
    view.updateState();
    loadData();
  }
}
