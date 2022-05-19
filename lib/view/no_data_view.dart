import 'package:dudv_base/config.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
    this.title,
    this.isListView = false,
    this.size,
    this.style,
  }) : super(key: key);

  final String? title;
  final bool isListView;
  final double? size;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    String? content;
    if (title != null && title!.isNotEmpty) {
      content = title!;
    }
    var tv = Text(
      content ?? DudvConfig.noDataValue,
      style: style ?? const TextStyle(color: Colors.black),
    );

    if (isListView) {
      return Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: tv,
            )
          ],
        ),
      );
    }

    return Center(
      child: Container(
        alignment: Alignment.center,
        height: size ?? 100,
        width: size ?? double.infinity,
        child: tv,
      ),
    );
  }
}
