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

  const RowStep({this.icon, this.title, Key? key}): super(key: key);

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
      return 'V??? tr??';
    } else if (permission == Permission.photos) {
      return 'H??nh ???nh';
    } else if (permission == Permission.microphone) {
      return 'Microphone';
    } else if (permission == Permission.speech) {
      return 'Nh???n d???ng gi???ng n??i';
    }
    return 'M??y ???nh';
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
      return '???ng d???ng c???n c?? quy???n v??? tr?? lu??n ho???t ?????ng v???i t??nh n??ng th??ng b??o camera t???t trong n???n';
    }
    return '???ng d???ng kh??ng c?? quy???n truy c???p "$_getText". Cung c???p quy???n ????? s??? d???ng t??nh n??ng $_getText';
  }

  String get _getTitleEnd {
    if (permission == Permission.location) {
      return '4. Ch???n lu??n lu??n';
    }
    return '4. Cho ph??p ???ng d???ng ????? s??? d???ng "$_getText"';
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
              child: Text('????ng',
                  style: Styles.copyStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)))),
          Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Text(_getTitle,
              textAlign: TextAlign.center,
              style: Styles.copyStyle(color: Colors.white))),
          const RowStep(icon: IconIOS.iSetting, title: '1. M??? ???ng d???ng c??i ?????t'),
          const RowStep(icon: IconIOS.iPrivacy, title: '2. Ch???n ri??ng t??'),
          RowStep(icon: _getIcon, title: '3. Ch???n "$_getText"'),
          RowStep(icon: IconIOS.iSwitch, title: _getTitleEnd),
          TextButton(
          onPressed: () => _openSetting(context),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Text('Cho ph??p truy c???p',
                style: Styles.copyStyle(color: Colors.white)),
          )),
        ]));
  }
}
