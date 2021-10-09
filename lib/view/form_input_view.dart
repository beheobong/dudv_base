import 'package:dudv_base/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'title_require_view.dart';

class FormInputView extends StatefulWidget {
  const FormInputView({
    Key? key,
    this.hint,
    this.controller,
    this.margin,
    this.textTitleInput,
    this.textSuggestion,
    this.validator,
    this.onTap,
    this.onEditingComplete,
    this.textInputAction,
    this.onChanged,
    this.textStyle,
    this.sugesStyle,
    this.prefix,
    this.keyboardType,
    this.focusBorder,
    this.disabledBorder,
    this.contentPadding,
    this.enabledBorder,
    this.prefixIcon,
    this.isPw = false,
    this.enable = true,
    this.hintStyle,
    this.suffixIcon,
    this.maxLength = TextField.noMaxLength,
    this.maxLines = 1,
    this.counterText = "",
    this.inputFormatter,
    this.obscureText,
    this.errorStyle,
    this.requireTitle = false,
    this.filled = true,
    this.autofocus = false,
    this.leftBorder = false,
    this.showMaxLength = false,
    this.fillColor = Colors.white,
    this.type = 1,
  }) : super(key: key);

  final String? hint;
  final String? textTitleInput;
  final String? textSuggestion;
  final FormFieldValidator<String>? validator;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? sugesStyle;
  final Function? onTap;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final EdgeInsets? margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool isPw;
  final int? maxLength;
  final bool enable;
  final int? maxLines;
  final String? counterText;
  final bool autofocus;
  final bool leftBorder;

  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final InputBorder? focusBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final EdgeInsets? contentPadding;

  final bool filled;
  final Color? fillColor;

  final bool? obscureText;
  final bool requireTitle;

  final bool showMaxLength;

  final int? type;

  @override
  _FormInputStateView createState() => _FormInputStateView();
}

class _FormInputStateView extends State<FormInputView> {
  String? _msgError;
  bool _obscureText = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPw;
  }

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      inputFormatters: widget.inputFormatter,
      controller: _editingController,
      autocorrect: false,
      autofocus: widget.autofocus,
      onTap: onTap,
      enabled: widget.enable,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onEditingComplete: widget.onEditingComplete,
      obscureText: widget.obscureText ?? _obscureText,
      style: widget.textStyle ?? Styles.copyStyle(),
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
          filled: _filled,
          fillColor: _fillColor,
          counterText: widget.counterText ?? '',
          prefix: widget.prefix,
          focusedBorder: _focusedBorder,
          disabledBorder: _disabledBorder,
          enabledBorder: _enabledBorder,
          contentPadding: widget.contentPadding,
          prefixIconConstraints: BoxConstraints(),
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon,
          hintStyle: widget.hintStyle ??
              Styles.copyStyle(
                color: Styles.grey32,
              ),
          suffixIcon: _suffixIcon),
      maxLength: widget.maxLength,
    );

    return Padding(
      padding: _margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.textTitleInput != null)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                    left: widget.type == 2 ? 10 : 0,
                  ),
                  child: TitleRequireView(
                    title: widget.textTitleInput!,
                    require: widget.requireTitle,
                  ),
                ),
                Spacer(),
                if (widget.maxLength != TextField.noMaxLength &&
                    widget.showMaxLength)
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Text(
                      '(${widget.maxLength})',
                      style: Styles.copyStyle(),
                    ),
                  )
              ],
            ),
          if (widget.type == 1) textField,
          if (widget.type == 2)
            Container(
              child: textField,
              decoration: BoxDecoration(
                  border: Border(
                      left: widget.leftBorder
                          ? BorderSide(width: 1, color: Styles.grey29)
                          : BorderSide.none,
                      top: BorderSide(width: 1, color: Styles.grey29),
                      bottom: BorderSide(
                          width: 1,
                          color: _msgError != null
                              ? Styles.red2
                              : Styles.grey29))),
            ),
          if (_msgError != null)
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: widget.type == 2 ? 10 : 0, right: 10),
              child: Text(
                _msgError!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.errorStyle ?? Styles.errorStyle(),
              ),
            ),
          if (widget.textSuggestion != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.textSuggestion!,
                style: widget.sugesStyle ??
                    Styles.copyStyle(
                      color: Styles.grey31,
                    ),
              ),
            )
        ],
      ),
    );
  }

  get _margin {
    if (widget.type == 2) {
      return EdgeInsets.zero;
    }
    return widget.margin ?? EdgeInsets.symmetric(horizontal: 20);
  }

  get _suffixIcon {
    if (widget.type == 2 && _msgError != null) {
      return IconButton(
        icon: Image.asset(
          'assets/icons/ic_error.png',
          width: 24,
          height: 24,
        ),
        onPressed: () {},
      );
    } else if (widget.isPw) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: _showHidePass,
      );
    }
    return widget.suffixIcon;
  }

  get _focusedBorder {
    if (widget.type == 2) {
      return InputBorder.none;
    }
    return widget.focusBorder;
  }

  get _disabledBorder {
    if (widget.type == 2) {
      if (_msgError != null) {
        return _boderUnderRed;
      } else {
        return _boderUnderGrey;
      }
    }
    return widget.disabledBorder;
  }

  get _boderUnderRed => UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.red,
      ));

  get _boderUnderGrey => OutlineInputBorder(
        borderSide: BorderSide(color: Styles.grey29, width: 1),
        borderRadius: BorderRadius.zero,
      );

  get _enabledBorder {
    if (widget.type == 2) {
      return InputBorder.none;
    }
    return widget.enabledBorder;
  }

  get _filled => widget.type == 2 ? true : widget.filled;

  get _fillColor {
    if (widget.type == 2) {
      if (_msgError != null) {
        return Styles.orange1;
      }
      return Colors.white;
    }
    return widget.fillColor;
  }

  bool checkValidate() {
    if (widget.validator != null) {
      setState(() {
        _msgError = widget.validator!(_editingController.text);
      });
    }
    return _msgError == null;
  }

  void resetValide() {
    setState(() {
      _msgError = null;
    });
  }

  void onTap() {
    if (_msgError != null) {
      setState(() {
        _msgError = null;
      });
    }
  }

  void _showHidePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController get _editingController =>
      widget.controller ?? _controller;

  String get text => _editingController.text;
  set text(String value) {
    _editingController.text = value;
  }

  void clear() {
    _editingController.clear();
  }
}
