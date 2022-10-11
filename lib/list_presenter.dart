import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'utils.dart';
import 'view/loading_view.dart';
import 'view/no_data_view.dart';

mixin ListPresenter {
  List list = [];
  bool isFirst = true;

  final controller = ScrollController();
  Future apiLoadData({required bool isFirst}) async {}
  void showAppBar() {}

  void hideAppBar() {}

  void updateState(List datas) {}
  // vì trùng với 1 vài presenter đã có hàm init rồi
  //=> supper các hàm sẽ không đc gọi => đổi init => initList
  initList() {
    controller.addListener(_listenter);
  }

  Future loadData() async {
    try {
      final listValue = await apiLoadData(isFirst: true);
      if (listValue is List) {
        list = listValue;
      }
    } catch (e, stack) {
      debugPrint('$e $stack');
      Utils.handleError(e);
    }
    isFirst = false;
    updateState(list);
  }

  void loadMore() async {
    try {
      final listValue = await apiLoadData(isFirst: false);
      if (listValue.isNotEmpty) {
        list.addAll(listValue);
      }
    } catch (e, stack) {
      debugPrint('$e $stack');
    }
    updateState(list);
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
    if (position.pixels == 0) {
      hideAppBar();
    }
  }

  Widget loadingView() {
    return const LoadingView();
  }

  Widget noDataView({bool isListView = false, String? title, double? size}) {
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
    return const Divider();
  }

  void scrollToTop() {
    if (controller.offset == 0.0) {
      controller.jumpTo(-200);
    } else {
      if (kDebugMode) {
        print('Scrool to top');
      }
      controller.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  Future onDestroy() {
    controller.removeListener(_listenter);
    controller.dispose();
    return Future.value(true);
  }
}
