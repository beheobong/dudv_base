import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'view/guide_permission_view.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    bool isLong = true,
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

  static void handleError(e) {
    final eValue = e.toString();
    if (eValue.contains('{')) {
      try {
        final eJsonValue = jsonDecode(eValue);
        if (eJsonValue is Map && eJsonValue.containsKey('message')) {
          showToast(eJsonValue['message']);
        } else {
          showToast(eValue);
        }
      } catch (e1, stack1) {
        debugPrint('$e1 $stack1');
        showToast(eValue);
      }
    } else {
      showToast(eValue);
    }
  }

  static Future navigatePage(BuildContext context, Widget widget) async {
    log('---||=======> ${widget.runtimeType}', name: 'NAVIGATE');
    return await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static void askPermission({
    required BuildContext context,
    required Function handle,
    required Permission permission,
  }) {
    if (isAndroid) {
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
    } else if (isIOS) {
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
    askPermission(
        context: context, handle: handle, permission: Permission.location);
  }

  static void askPermissionPhotos(BuildContext context, Function handle) {
    askPermission(
        context: context, handle: handle, permission: Permission.photos);
  }

  static void askPermissionCamera(BuildContext context, Function handle) {
    askPermission(
        context: context, handle: handle, permission: Permission.camera);
  }

  static void askPermissionMic(BuildContext context, Function handle) {
    askPermission(
        context: context, handle: handle, permission: Permission.microphone);
  }

  static void askPermissionStore(BuildContext context, Function handle) {
    askPermission(
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
    ValueChanged<BuildContext>? ctx,
  }) {
    return showDialog(
        context: context,
        useRootNavigator: useRootNavigator,
        barrierDismissible: false,
        builder: (BuildContext mContext) {
          if (ctx != null) {
            ctx(mContext);
          }
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

  static const bool isWeb = kIsWeb;
  static final bool isAndroid =
      (defaultTargetPlatform == TargetPlatform.android);
  static final bool isIOS = (defaultTargetPlatform == TargetPlatform.iOS);

  static Map<String, dynamic>? toJson(String? value) {
    try {
      if (isNotEmpty(value) && value!.contains('{')) {
        return jsonDecode(value);
      }
      return null;
    } catch (e, stack) {
      debugPrint('$e $stack');
      return null;
    }
  }
}
