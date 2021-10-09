import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'view/guide_permission_view.dart';

class Utils {
  static void showToast(String title, {bool isLong: false}) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black.withOpacity(0.5),
      textColor: Colors.white,
    );
  }

  static Future navigatePage(BuildContext context, Widget widget) async {
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
        if (value == PermissionStatus.denied) {
          permission.request().then((value2) {
            if (value == PermissionStatus.granted) {
              handle();
            }
          });
        } else if (value == PermissionStatus.granted) {
          handle();
        } else {
          permission.request().then((value3) {
            if (value3 == PermissionStatus.granted) {
              handle();
            }
          });
        }
      });
    } else if (Platform.isIOS) {
      permission.status.then((value) {
        // if (value == PermissionStatus.undetermined) {
        //   //first request
        //   permission.request().then((value) {
        //     if (value == PermissionStatus.granted) {
        //       handle();
        //     }
        //   });
        // } else
        if (value == PermissionStatus.denied ||
                value == PermissionStatus.restricted
            // || value == PermissionStatus.disabled
            ) {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  GuidePermissionView(permission)));
        } else {
          handle();
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

  static Future navigatePageRoute(BuildContext context, Widget widget) {
    return Navigator.of(context).push(PageRouteBuilder(
        opaque: false, pageBuilder: (BuildContext context, _, __) => widget));
  }

  static bool imageOk(String? value) {
    debugPrint('UtilsImageOk $value');
    if (value == null || value.trim().isEmpty || !value.contains('http')) {
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

  static bool isNotEmpty(String text) {
    return !isEmpty(text);
  }

  static Future showModalDialog({
    required BuildContext context,
    required Widget view,
    bool useRootNavigator = false,
  }) {
    return showDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: view,
            ),
          );
        });
  }
}
