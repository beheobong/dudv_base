import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class NoDataView extends StatelessWidget {
  final String title;
  final bool isListView;
  final double size;

  const NoDataView({Key key, this.title, this.isListView = false, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String content;
    if (title != null && title.isNotEmpty) {
      content = title;
    }
    var tv = Text(
      content ?? 'No data',
      style: TextStyle(color: Colors.black),
    );

    if (isListView)
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
