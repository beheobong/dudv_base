import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

class TitleRequireView extends StatelessWidget {
  const TitleRequireView({
    Key? key,
    required this.title,
    this.require = true,
    this.dot = '※',
  }) : super(key: key);

  final String title;
  final String dot;
  final bool require;

  @override
  Widget build(BuildContext context) {
    if (!require) {
      return Text(
        title,
        style: Styles.copyStyle(),
      );
    }
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: title,
        style: Styles.copyStyle(),
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0, -6),
              child: Text(
                dot,
                style: Styles.cusText(
                  size: 10,
                  color: Styles.red2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
