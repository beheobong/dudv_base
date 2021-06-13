import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IconIOS {
  static final String iSetting = 'assets/icons_ios/ios_settings.png';
  static final String iNotification = 'assets/icons_ios/ios_notification.png';
  static final String iSwitch = 'assets/icons_ios/ios_switch.png';
  static final String iSwitchOff = 'assets/icons_ios/ios_switch_off.png';
  static final String iLocationPrivacy = 'assets/icons_ios/ios_location.png';
  static final String iCameraPrivacy = 'assets/icons_ios/ios_camera.png';
  static final String iPhotosPrivacy = 'assets/icons_ios/ios_photos.png';
  static final String iPrivacy = 'assets/icons_ios/ios_privacy.png';
  static final String icMicrophone = 'assets/icons_ios/microphone_ios.png';

}

class RowStep extends StatelessWidget {
  final String icon;
  final String title;

  RowStep({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  image: DecorationImage( 
                    image: AssetImage(icon),
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Flexible(
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)))
        ],
      ),
    );
  }
}


class GuidePermissionView extends StatelessWidget {
  final Permission permission;

  GuidePermissionView({this.permission});

  _closeGuide(context) {
    Navigator.pop(context);
  }

  _openSetting(context) {
    Navigator.pop(context);
    openAppSettings();
  }

  String get _getText {
    if (permission == Permission.location ||
        permission == Permission.locationAlways) {
      return 'Location';
    } else if (permission == Permission.photos) {
      return 'Photos';
    } else if (permission == Permission.microphone) {
      return 'Microphone';
    } else if (permission == Permission.speech) {
      return 'Speech Recognition';
    }
    return 'Camera';
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
    switch (permission) {
      case Permission.location:
        return 'App need position permission always to operate with background cool fine camera notification feature';
      default:
        return 'App have no access "$_getText". enable this feature to use $_getText';
    }
  }

  String get _getTitleEnd {
    switch (permission) {
      case Permission.location:
        return '4. Choose always';
      default:
        return '4. Allows the app to use it "$_getText"';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0), // here the desired height
            child: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black.withOpacity(0.85),
                brightness: Brightness.dark)),
        backgroundColor: Colors.black.withOpacity(0.85),
        body: Container(
            child: Column(children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                  onPressed: () => _closeGuide(context),
                  child: Text('Close',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)))),
          Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(_getTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white))),
          RowStep(icon: IconIOS.iSetting, title: '1. Open the settings app'),
          RowStep(icon: IconIOS.iPrivacy, title: '2. Choose privacy'),
          RowStep(icon: _getIcon, title: '3. Choose "$_getText"'),
          RowStep(icon: IconIOS.iSwitch, title: _getTitleEnd),
          FlatButton(
              onPressed: () => _openSetting(context),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Text('Allow access',
                    style: TextStyle(color: Colors.white)),
              )),
        ])));
  }
}
