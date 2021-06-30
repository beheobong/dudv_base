import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'contract.dart';
import 'utils.dart';
import 'view/no_data_view.dart';

mixin ListPresenter {
  List get list;
  set list(List values);
  Contract get view;
  bool get isFirst;
  set isFirst(bool value);
  final ScrollController controller = ScrollController();
  Future apiLoadData({bool isFirst});
   void showAppBar() {}

  void hideAppBar() {}

  init() {
    controller.addListener(_listenter);
  }

  Future loadData() async {
    try {
      final _list = await apiLoadData(isFirst: true);
      if (_list is List) {
        list = _list;
      }
    } catch (e, stack) {
      debugPrint('$e $stack');
      Utils.showToast(e.message);
    }
    isFirst = false;
    view.updateState();
  }

  void loadMore() async {
    try {
      final _list = await apiLoadData(isFirst: false);
      if (_list.isNotEmpty) {
        list.addAll(_list);
        view.updateState();
      }
    } catch (e, stack) {
      debugPrint('$e $stack');
    }
  }

 void _listenter() {
    final maxScroll = controller.position.maxScrollExtent;
    if (controller.offset >= maxScroll && !controller.position.outOfRange) {
      loadMore();
    }
    ScrollPosition position = controller.position;
    if (position.userScrollDirection == ScrollDirection.reverse) {
      hideAppBar();
    }
    if (position.userScrollDirection == ScrollDirection.forward) {
      showAppBar();
    }
    if(position.pixels == 0){
       hideAppBar();
    }
  }

  Widget loadingView() {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Center(
            child: Platform.isAndroid
                ? const CircularProgressIndicator()
                : const CupertinoActivityIndicator(
                    radius: 15,
                  )));
  }

  Widget noDataView({bool isListView = false, String title, double size}) {
    return NoDataView(
      title: title,
      isListView: isListView,
      size: size,
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (isFirst && list.isEmpty) {
      return loadingView();
    } else {
      if (list.isEmpty) {
        return noDataView();
      } else {
        return itemBuild(context, index);
      }
    }
  }

  Widget itemBuild(BuildContext context, int index) {
    return Container();
  }

  Widget separatorBuilder(BuildContext context, int index) {
    return Divider();
  }

  void scrollToTop() {
    // if (controller.offset == 0.0) {
    //   double heigh = MediaQuery.of(context).size.height;
    //   controller.jumpTo(-heigh);
    // } else {
    //   print('Scrool to top');
    //   controller.animateTo(0.0,
    //       curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    // }
  }

  Future dispose() {
    controller.removeListener(_listenter);
    controller.dispose();
    return Future.value(true);
  }
}
