import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme/text_field_style.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';

typedef WidgetLimitBuilder = Widget Function(
    BuildContext context, int length, int maxLength);

class ETextField extends StatefulWidget {
  final String? value;
  final String? placeholder;
  final ETextFieldStyle? style;
  final bool clear;
  final bool obscureText;
  final bool showPassword;
  final double? height;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;

  ///展示字数统计
  final bool showWordLimit;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextStyle? placeholderTextStyle;
  final WidgetLimitBuilder? limitBuilder;
  final FocusNode? focusNode;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? minLines;
  final bool expands;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final VoidCallback? onEditingComplete;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final EdgeInsetsGeometry? contentPadding;

  const ETextField({
    Key? key,
    this.value,
    this.focusNode,
    this.placeholder,
    this.style,
    this.clear = false,
    this.obscureText = false,
    this.showPassword = false,
    this.height,
    this.suffix,
    this.prefix,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.onChanged,
    this.onSubmitted,
    this.showWordLimit = false,
    this.maxLength,
    this.inputFormatters,
    this.enabled,
    this.textStyle,
    this.placeholderTextStyle,
    this.limitBuilder,
    this.strutStyle,
    this.textDirection,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.autocorrect = true,
    this.smartDashesType,
    this.enableSuggestions = true,
    this.expands = false,
    this.minLines,
    this.smartQuotesType,
    this.mouseCursor,
    this.onTap,
    this.autofillHints,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableIMEPersonalizedLearning = true,
    this.enableInteractiveSelection = true,
    this.keyboardAppearance,
    this.maxLengthEnforcement,
    this.onAppPrivateCommand,
    this.onEditingComplete,
    this.restorationId,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.selectionControls,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<ETextField> createState() => _ETextFieldState();
}

class _ETextFieldState extends State<ETextField> {
  late TextEditingController _controller;
  late String _value;
  late bool _showPassword;
  int _wordLength = 0;
  double _textHeight = 0;

  @override
  initState() {
    _value = widget.value ?? '';
    _controller = TextEditingController()..text = _value;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: _value.length));
    _wordLength = _value.length;
    _showPassword = false;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ETextField oldWidget) {
    // if (oldWidget.value != widget.value) {
    _value = widget.value ?? '';
    _controller = TextEditingController()..text = _value;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: _value.length));
    _wordLength = _value.length;
    // }
    super.didUpdateWidget(oldWidget);
  }

  void _getTextHeight(TextStyle textStyle) {
    var textPainter = TextPainter(
      text: TextSpan(
        text: '',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout();
    _textHeight = textPainter.height;
  }

  void _onClickClearIcon() {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = '';
      _controller.text = _value;
    });
  }

  void _onClickPasswordIcon() {
    if (!mounted) {
      return;
    }
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _onValueChange(String value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _value = value;
    });
    if (widget.showWordLimit) {
      _computeWordCount();
    }
    widget.onChanged?.call(value);
  }

  /// 计算字数，不算正在编辑的文字
  void _computeWordCount() {
    var valueLength = _controller.value.text.length;
    var composingLength =
        _controller.value.composing.end - _controller.value.composing.start;
    if (!mounted) {
      return;
    }
    setState(() {
      _wordLength = valueLength - composingLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    EleThemeData eleTheme = EleTheme.of(context);
    var _style = eleTheme.textFieldStyle?.merge(widget.style) ?? widget.style;

    List<TextInputFormatter> _inputFormatters = [];
    _inputFormatters.addAll(widget.inputFormatters ?? []);
    if (widget.maxLength != null) {
      _inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }

    var _textStyle = widget.textStyle ??
        TextStyle(color: _style?.fontColor ?? eleTheme.regularTextColor);
    var _placeholderTextStyle = widget.placeholderTextStyle ??
        TextStyle(color: _style?.placeholderColor ?? eleTheme.placeholderColor);
    _getTextHeight(_textStyle);
    EdgeInsetsGeometry? contentPadding;
    if (widget.height != null) {
      if (widget.maxLines == null || widget.maxLines == 1) {
        contentPadding = widget.contentPadding ??
            (widget.height! > _textHeight
                ? EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: (widget.height! - _textHeight) / 2)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 0));
      }
    }
    var textField = TextField(
      key: widget.key,
      controller: _controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText && !_showPassword,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      onChanged: _onValueChange,
      onSubmitted: widget.onSubmitted,
      inputFormatters: _inputFormatters,
      enabled: widget.enabled,
      style: _textStyle,
      decoration: InputDecoration(
        fillColor: _style?.backgroundColor ?? eleTheme.backgroundColorWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: _style?.borderColor ??
                  eleTheme.borderColorBase ??
                  Colors.transparent),
          borderRadius: _style?.borderRadius ??
              BorderRadius.circular(eleTheme.borderRadiusBase ?? 0.0),
        ),
        hintText: widget.placeholder,
        hintStyle: _placeholderTextStyle,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: _style?.focusBorderColor ??
                  eleTheme.primaryColor ??
                  Colors.transparent),
          borderRadius: _style?.borderRadius ??
              BorderRadius.circular(eleTheme.borderRadiusBase ?? 0.0),
        ),
        suffixIcon: _buildSuffix(_style),
        prefixIcon: widget.prefix,
        contentPadding: contentPadding,
      ),
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onEditingComplete: widget.onEditingComplete,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      mouseCursor: widget.mouseCursor,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      restorationId: widget.restorationId,
    );
    if (widget.height != null) {
      return SizedBox(
        height: widget.height,
        child: textField,
      );
    }
    return textField;
  }

  Widget? _buildSuffix(ETextFieldStyle? style) {
    Widget? _clearWidget = (widget.clear && _value.isNotEmpty)
        ? IconButton(
            onPressed: _onClickClearIcon,
            icon: Icon(
              Icons.highlight_off,
              color: style?.clearColor ?? EleTheme.of(context).borderColorBase,
            ),
          )
        : null;

    Widget? _showPasswordWidget = (widget.obscureText && widget.showPassword)
        ? IconButton(
            onPressed: _onClickPasswordIcon,
            icon: Icon(
              _showPassword ? Icons.visibility_off : Icons.visibility,
              color: style?.clearColor ?? EleTheme.of(context).borderColorBase,
            ),
          )
        : null;

    if (_clearWidget == null &&
        _clearWidget == _showPasswordWidget &&
        widget.suffix == null &&
        !widget.showWordLimit) {
      return null;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: (widget.maxLines == null || widget.maxLines == 1)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      children: [
        _clearWidget ?? Container(),
        _showPasswordWidget ?? Container(),
        Container(
          padding: widget.suffix == null
              ? EdgeInsets.zero
              : const EdgeInsets.only(right: 12),
          child: widget.suffix,
        ),
        widget.showWordLimit ? _buildWordLimit(style) : Container(),
      ],
    );
  }

  Widget _buildWordLimit(ETextFieldStyle? style) {
    var text = widget.limitBuilder
            ?.call(context, _wordLength, widget.maxLength ?? 0) ??
        Text(
          '$_wordLength/${widget.maxLength}',
          style: TextStyle(color: style?.placeholderColor),
        );
    if (widget.maxLines == null || widget.maxLines == 1) {
      return text;
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12, bottom: 12),
      child: text,
    );
  }
}
