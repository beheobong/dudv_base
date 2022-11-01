import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../themes/styles.dart';

class IconIOS {
  static const String iSetting = 'assets/icons_ios/ios_settings.png';
  static const String iNotification = 'assets/icons_ios/ios_notification.png';
  static const String iSwitch = 'assets/icons_ios/ios_switch.png';
  static const String iSwitchOff = 'assets/icons_ios/ios_switch_off.png';
  static const String iLocationPrivacy = 'assets/icons_ios/ios_location.png';
  static const String iCameraPrivacy = 'assets/icons_ios/ios_camera.png';
  static const String iPhotosPrivacy = 'assets/icons_ios/ios_photos.png';
  static const String iPrivacy = 'assets/icons_ios/ios_privacy.png';
  static const String icMicrophone = 'assets/icons_ios/microphone_ios.png';
}

class RowStep extends StatelessWidget {
  final String? icon;
  final String? title;

  const RowStep({this.icon, this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icon!),
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Flexible(
              child: Text(title!,
                  style: Styles.copyStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)))
        ],
      ),
    );
  }
}

class GuidePermissionView extends StatelessWidget {
  final Permission permission;

  const GuidePermissionView(this.permission, {Key? key}) : super(key: key);

  static String? closeTx;
  static String? allowTx;
  static String? locationTx;

  void _closeGuide(context) {
    Navigator.pop(context);
  }

  void _openSetting(context) {
    Navigator.pop(context);
    openAppSettings();
  }

  String get _getText {
    if (permission == Permission.location ||
        permission == Permission.locationAlways) {
      return 'Vị trí';
    } else if (permission == Permission.photos) {
      return 'Hình ảnh';
    } else if (permission == Permission.microphone) {
      return 'Microphone';
    } else if (permission == Permission.speech) {
      return 'Nhận dạng giọng nói';
    }
    return 'Máy ảnh';
  }

  String get _getIcon {
    if (permission == Permission.location ||
        permission == Permission.locationAlways) {
      return IconIOS.iLocationPrivacy;
    } else if (permission == Permission.photos) {
      return IconIOS.iPhotosPrivacy;
    } else if (permission == Permission.microphone) {
      return IconIOS.icMicrophone;
    }
    return IconIOS.iPhotosPrivacy;
  }

  String get _getTitle {
    if (permission == Permission.location) {
      return 'Ứng dụng cần có quyền vị trí luôn hoạt động với tính năng thông báo camera tốt trong nền';
    }
    return 'Ứng dụng không có quyền truy cập "$_getText". Cung cấp quyền để sử dụng tính năng $_getText';
  }

  String get _getTitleEnd {
    if (permission == Permission.location) {
      return '4. Chọn luôn luôn';
    }
    return '4. Cho phép ứng dụng để sử dụng "$_getText"';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black.withOpacity(0.85),
                systemOverlayStyle: SystemUiOverlayStyle.dark)),
        backgroundColor: Colors.black.withOpacity(0.85),
        body: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => _closeGuide(context),
                  child: Text('Đóng',
                      style: Styles.copyStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)))),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(_getTitle,
                  textAlign: TextAlign.center,
                  style: Styles.copyStyle(color: Colors.white))),
          const RowStep(
              icon: IconIOS.iSetting, title: '1. Mở ứng dụng cài đặt'),
          const RowStep(icon: IconIOS.iPrivacy, title: '2. Chọn riêng tư'),
          RowStep(icon: _getIcon, title: '3. Chọn "$_getText"'),
          RowStep(icon: IconIOS.iSwitch, title: _getTitleEnd),
          TextButton(
              onPressed: () => _openSetting(context),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Text('Cho phép truy cập',
                    style: Styles.copyStyle(color: Colors.white)),
              )),
        ]));
  }
}
