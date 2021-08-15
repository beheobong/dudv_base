import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

class ActionNotiView extends StatelessWidget {
  const ActionNotiView({
    Key key,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);
  final String icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          IconButton(
            icon: Image(
              image: AssetImage(icon),
              width: 18,
              height: 18,
            ),
            onPressed: onTap,
          ),
          Positioned(
            bottom: 14,
            right: 2,
            child: Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(right: 10, top: 5),
              decoration: BoxDecoration(
                color: Styles.orange,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
