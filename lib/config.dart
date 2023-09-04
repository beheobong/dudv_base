import 'package:dudv_base/dudv_base.dart';
import 'package:flutter/material.dart';

class DudvConfig {
  static String noDataValue = 'Không có dữ liệu';
  static Widget? loadingView;
  static Color? bgLoadingValue;
  static Color bgBtn = Styles.colorMain;
  static double borderBtn = 4;

  static void config({
    String? noData,
    Widget? loading,
    Color? bgLoading,
    Color? bgButton,
    double? borderButton,
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
    if (bgButton != null) {
      bgBtn = bgButton;
    }
    if (borderButton != null) {
      borderBtn = borderButton;
    }
  }

  static ValueChanged<String>? showError;
  static Function(dynamic e, dynamic stack)? catchError;

  static void setShowError(
    ValueChanged<String> value, {
    Function(dynamic e, dynamic stack)? catchError,
  }) {
    showError = value;
    catchError = catchError;
  }
}
