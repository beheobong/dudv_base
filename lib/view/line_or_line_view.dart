import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

class LineOrLineView extends StatelessWidget {
  const LineOrLineView({
    Key? key,
    this.textOr,
    this.styleOr,
    this.lineColor,
    this.lineHeight,
  }) : super(key: key);

  final String? textOr;
  final TextStyle? styleOr;
  final Color? lineColor;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _lineView(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              textOr ?? 'or',
              style: styleOr ?? Styles.copyStyle(color: Styles.grey52),
            ),
          ),
          _lineView(),
        ],
      ),
    );
  }

  Widget _lineView() {
    return Expanded(
      child: Divider(
        height: lineHeight ?? 2,
        color: lineColor ?? Styles.grey51,
      ),
    );
  }
}
