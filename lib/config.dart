import 'package:flutter/material.dart';

class DudvConfig {
  static String noDataValue = 'Không có dữ liệu';
  static Widget? loadingView;
  static Color? bgLoadingValue;

  static void config({
    String? noData,
    Widget? loading,
    Color? bgLoading,
  }) {
    if (noData != null) {
      noDataValue = noData;
    }
    if (loading != null) {
      loadingView = loading;
    }
    if (bgLoading != null) {
      bgLoadingValue = bgLoading;
    }
  }
}
