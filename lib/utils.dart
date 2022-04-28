import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'view/guide_permission_view.dart';

class Utils {
  static Widget? guidePermissionView;

  static void setGuiderPmsV(Widget value) {
    guidePermissionView = value;
  }

  static Color? tsTxColor;
  static Color? tsBgColor;

  static void setTs(Color txColor, Color bgColor) {
    tsTxColor = txColor;
    tsBgColor = bgColor;
  }

  static Future showToast(
    String title, {
    bool isLong: true,
    ToastGravity? gravity,
  }) {
    return Fluttertoast.showToast(
      msg: title,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      backgroundColor: tsBgColor ?? Colors.black.withOpacity(0.5),
      textColor: tsTxColor ?? Colors.white,
    );
  }

  static Future navigatePage(BuildContext context, Widget widget) async {
    log('---||=======> ${widget.runtimeType}', name: 'NAVIGATE');
    return await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static void _askPermission({
    required BuildContext context,
    required Function handle,
    required Permission permission,
  }) {
    if (Platform.isAndroid) {
      permission.status.then((value) {
        if (value != PermissionStatus.granted) {
          permission.request().then((value2) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else {
          handle();
        }
      });
    } else if (Platform.isIOS) {
      permission.status.then((value) {
        debugPrint('Utils._askPermission $value');
        if (value != PermissionStatus.granted) {
          permission.request().then((value2) {
            debugPrint('Utils.request $value2');
            if (value2 == PermissionStatus.granted) {
              handle();
            } else {
              Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      guidePermissionView ?? GuidePermissionView(permission)));
            }
          });
        } else if (value == PermissionStatus.granted) {
          handle();
        } else {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  guidePermissionView ?? GuidePermissionView(permission)));
        }
      });
    }
  }

  static void askPermissionGPS(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.location);
  }

  static void askPermissionPhotos(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.photos);
  }

  static void askPermissionCamera(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.camera);
  }

  static void askPermissionStore(BuildContext context, Function handle) {
    _askPermission(
        context: context, handle: handle, permission: Permission.storage);
  }

  static Future<bool> hasPermissionStorage() async {
    return await Permission.storage.isGranted;
  }

  static Future navigatePageRoute(BuildContext context, Widget widget) {
    return Navigator.of(context).push(PageRouteBuilder(
        opaque: false, pageBuilder: (BuildContext context, _, __) => widget));
  }

  static void navigateToRoot(
    BuildContext context,
  ) {
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static bool imageOk(String? value) {
    if (value == null ||
        value.trim().isEmpty ||
        !value.contains('http') ||
        value.contains('null')) {
      return false;
    }
    return true;
  }

  static bool isEmpty(String? text) {
    return text == null ||
        text.trim().isEmpty ||
        text == 'null' ||
        text.isEmpty;
  }

  static bool isNotEmpty(String? text) {
    return !isEmpty(text);
  }

  static Future showModalDialog({
    required BuildContext context,
    required Widget view,
    double radius = 10,
    bool useRootNavigator = false,
    Color? bg,
  }) {
    return showDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius))),
              child: view,
            ),
          );
        });
  }
}
