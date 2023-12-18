import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'config.dart';
import 'utils.dart';
import 'view/loading_view.dart';
import 'view/no_data_view.dart';

mixin ListPresenter {
  List list = [];
  bool isFirst = true;
  bool showErr = true;
  BuildContext get context;
  late final NavigatorState _navigator = Navigator.of(context);

  final controller = ScrollController();
  Future apiLoadData({required bool isFirst}) async {}
  void showAppBar() {}
  void handleError(e) {
    Utils.handleError(context, e);
  }

  void hideAppBar() {}
  // có 2 cách sử dụng
  // 1 là updateState để lấy tất cả ds
  void updateState(List datas) {}
  // 2 là update lẻ theo từng hàm load dữ liệu
  // để phân biệt lần đầu vs lần sau thì tự xử lý ở view
  void updateData(List datas) {}
  // vì trùng với 1 vài presenter đã có hàm init rồi
  //=> supper các hàm sẽ không đc gọi => đổi init => initList
  initList({bool notHandle = true}) {
    showErr = notHandle;
    controller.addListener(_listenter);
  }

  Future loadData() async {
    try {
      final listValue = await apiLoadData(isFirst: true);
      if (listValue is List) {
        list = listValue;
        updateData(listValue);
      }
    } catch (e, stack) {
      if (DudvConfig.catchError != null && context.mounted) {
        DudvConfig.catchError!(context, e, stack);
      }
      debugPrint('$e $stack');
      if (showErr) {
        if (DudvConfig.showError != null) {
          DudvConfig.showError!(e.toString());
        } else {
          if (_navigator.mounted) {
            Utils.handleError(context, e);
          }
        }
      } else {
        handleError(e);
      }
    }
    isFirst = false;
    updateState(list);
  }

  void loadMore() async {
    try {
      final listValue = await apiLoadData(isFirst: false);
      if (listValue.isNotEmpty) {
        updateData(listValue);
        list.addAll(listValue);
      }
    } catch (e, stack) {
      debugPrint('$e $stack');
      if (!showErr) {
        handleError(e);
      }
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
      showAppBar();
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
