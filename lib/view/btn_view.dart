import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class BtnView extends StatelessWidget {
  const BtnView(
      {Key? key,
      required this.onPress,
      required this.title,
      this.margin,
      this.decoration,
      this.textStyle,
      this.padding})
      : super(key: key);

  final Function()? onPress;
  final String? title;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
        decoration: decoration ??
            BoxDecoration(
              color: DudvConfig.bgBtn,
              borderRadius: BorderRadius.circular(DudvConfig.borderBtn),
              border: Border.all(color: Colors.transparent, width: 1),
            ),
        child: Text(
          title!,
          style: textStyle ?? Styles.copyStyle(color: Colors.white),
        ),
      ),
    );
  }
}
