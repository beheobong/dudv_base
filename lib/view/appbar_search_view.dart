import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';

class AppBarSearchView extends StatefulWidget implements PreferredSizeWidget {
  const AppBarSearchView({
    Key? key,
    this.hintText,
    this.onTap,
    this.enabled = true,
    this.leading,
  }) : super(key: key);

  final String? hintText;
  final Function()? onTap;
  final bool enabled;
  final Widget? leading;

  @override
  _AppBarSearchViewState createState() => _AppBarSearchViewState();

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}

class _AppBarSearchViewState extends State<AppBarSearchView> {
  final _edController = TextEditingController();
  bool _showClear = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: widget.leading != null ? 0 : 10,
          right: 10,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(width: 1, color: Styles.grey))),
        alignment: Alignment.center,
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              if (widget.leading != null) widget.leading!,
              Expanded(
                child: TextFormField(
                  enabled: widget.enabled,
                  controller: _edController,
                  autocorrect: false,
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      hintText: widget.hintText ?? '',
                      hintStyle: Styles.copyStyle(color: Styles.grey14),
                      fillColor: Styles.grey41,
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Styles.grey54,
                      ),
                      suffixIcon: !_showClear
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.clear,
                                size: 18,
                                color: Styles.black7,
                              ),
                              onPressed: _onClearText)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).pop();
  }

  void _onClearText() {
    _edController.clear();
    _showClear = false;
    setState(() {});
  }

  void onChanged(String value) {
    if (!_showClear && value.isNotEmpty) {
      setState(() {
        _showClear = true;
      });
    }
  }

  String get text => _edController.text;
}
