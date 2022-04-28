import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

class LineView extends StatelessWidget {
  const LineView({
    Key? key,
    this.margin,
    this.lineColor,
    this.lineHeight,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Color? lineColor;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? EdgeInsets.zero,
        height: lineHeight ?? 1,
        width: double.infinity,
        color: lineColor ?? Styles.grey24);
  }
}
