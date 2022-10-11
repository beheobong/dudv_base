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
  State<StatefulWidget> createState() => _AppBarSearchViewState();

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
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
        decoration: const BoxDecoration(
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
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Styles.grey54,
                      ),
                      suffixIcon: !_showClear
                          ? null
                          : IconButton(
                              icon: const Icon(
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
