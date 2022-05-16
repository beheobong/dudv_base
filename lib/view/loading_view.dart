import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.size,
  }) : super(key: key);

  final Size? size;
  static Color? _color;

  static void color(Color color) {
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size?.width ?? double.infinity,
        height: size?.height ?? 100,
        child: Center(
            child: Utils.isAndroid
                ? CircularProgressIndicator(
                    color: _color,
                  )
                : CupertinoActivityIndicator(
                    radius: 15,
                    color: _color,
                  )));
  }
}
