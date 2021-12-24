import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'border_style.dart';
import 'button_style.dart';
import 'checkbox_style.dart';
import 'dropdown_style.dart';
import 'image_crop_style.dart';
import 'image_style.dart';
import 'input_number_style.dart';
import 'radio_style.dart';
import 'rate_style.dart';
import 'slider_style.dart';
import 'switch_style.dart';
import 'text_field_style.dart';
import 'dialog_style.dart';
import 'page_view_style.dart';

class EleThemeData with Diagnosticable {
  const EleThemeData.raw({
    required this.primaryColor,
    required this.primaryTextColor,
    required this.regularTextColor,
    required this.secondaryTextColor,
    required this.placeholderColor,
    required this.borderColorBase,
    required this.borderColorLight,
    required this.borderColorLighter,
    required this.borderColorExtraLight,
    required this.backgroundColorBase,
    required this.backgroundColorWhite,
    required this.backgroundColorBlack,
    required this.borderRadiusBase,
    required this.borderStyle,
    required this.buttonStyle,
    required this.imageStyle,
    required this.radioStyle,
    required this.checkboxStyle,
    required this.textFieldStyle,
    required this.inputNumberStyle,
    required this.switchStyle,
    required this.sliderStyle,
    required this.rateStyle,
    required this.imageCropStyle,
    required this.dropdownStyle,
    required this.pageViewStyle,
    required this.dialogStyle,
  })  : assert(primaryColor != null),
        assert(primaryTextColor != null),
        assert(regularTextColor != null),
        assert(secondaryTextColor != null),
        assert(placeholderColor != null),
        assert(borderColorBase != null),
        assert(borderColorLight != null),
        assert(borderColorLighter != null),
        assert(borderColorExtraLight != null),
        assert(backgroundColorBase != null),
        assert(backgroundColorWhite != null),
        assert(backgroundColorBlack != null),
        assert(borderRadiusBase != null),
        assert(borderStyle != null),
        assert(buttonStyle != null),
        assert(imageStyle != null),
        assert(radioStyle != null),
        assert(checkboxStyle != null),
        assert(textFieldStyle != null),
        assert(inputNumberStyle != null),
        assert(switchStyle != null),
        assert(sliderStyle != null),
        assert(rateStyle != null),
        assert(imageCropStyle != null),
        assert(dropdownStyle != null),
        assert(pageViewStyle != null),
        assert(dialogStyle != null);

  factory EleThemeData({
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? dangerColor,
    Color? infoColor,
    Color? primaryTextColor,
    Color? regularTextColor,
    Color? secondaryTextColor,
    Color? placeholderColor,
    Color? borderColorBase,
    Color? borderColorLight,
    Color? borderColorLighter,
    Color? borderColorExtraLight,
    Color? backgroundColorBase,
    Color? backgroundColorWhite,
    Color? backgroundColorBlack,
    double? borderRadiusBase,
    EBorderStyle? borderStyle,
    EButtonStyle? buttonStyle,
    EImageStyle? imageStyle,
    ERadioStyle? radioStyle,
    ECheckboxStyle? checkboxStyle,
    ETextFieldStyle? textFieldStyle,
    EInputNumberStyle? inputNumberStyle,
    ESwitchStyle? switchStyle,
    ESliderStyle? sliderStyle,
    ERateStyle? rateStyle,
    EImageCropStyle? imageCropStyle,
    EDropdownStyle? dropdownStyle,
    EPageViewStyle? pageViewStyle,
    EDialogStyle? dialogStyle,
  }) {
    primaryColor ??= const Color(0xFF409EFF);
    successColor ??= const Color(0xFF67C23A);
    warningColor ??= const Color(0xFFE6A23C);
    dangerColor ??= const Color(0xFFF56C6C);
    infoColor ??= const Color(0xFF909399);

    primaryTextColor ??= const Color(0xFF303133);
    regularTextColor ??= const Color(0xFF606266);
    secondaryTextColor ??= const Color(0xFF909399);
    placeholderColor ??= const Color(0xFFC0C4CC);

    borderColorBase ??= const Color(0xFFDCDFE6);
    borderColorLight ??= const Color(0xFFE4E7ED);
    borderColorLighter ??= const Color(0xFFEBEEF5);
    borderColorExtraLight ??= const Color(0xFFF2F6FC);

    backgroundColorBase ??= const Color(0xFFF5F7FA);
    backgroundColorWhite ??= const Color(0xFFFFFFFF);
    backgroundColorBlack ??= const Color(0xFF000000);

    borderRadiusBase ??= 4.0;

    // const EBorderStyle _defaultBorderStyle = EBorderStyle();
    //
    // borderStyle = _defaultBorderStyle.merge(borderStyle);
    //
    // final EButtonStyle _defaultButtonStyle = EButtonStyle(
    //   loadingColor: Colors.white,
    //   radius: BorderRadius.all(Radius.circular(borderRadiusBase)),
    // );
    //
    // buttonStyle = _defaultButtonStyle.merge(buttonStyle);
    //
    // EImageStyle _defaultImageStyle = EImageStyle.from(borderColorLight);
    // imageStyle = _defaultImageStyle.merge(imageStyle);
    //
    // ERadioStyle _defaultRadioStyle = ERadioStyle(
    //   padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
    //   space: 3.0,
    // );
    // radioStyle = _defaultRadioStyle.merge(radioStyle);
    //
    // ECheckboxStyle _defaultCheckboxStyle = ECheckboxStyle(
    //   padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
    //   space: 3.0,
    // );
    // checkboxStyle = _defaultCheckboxStyle.merge(checkboxStyle);
    //
    // textFieldStyle = textFieldStyle ?? ETextFieldStyle();
    // inputNumberStyle = inputNumberStyle ?? const EInputNumberStyle();
    // switchStyle = switchStyle ?? ESwitchStyle();
    // sliderStyle = sliderStyle ?? ESliderStyle();
    //
    // ERateStyle _defaultRateStyle = ERateStyle(
    //   activeColor: primaryColor,
    //   inactiveColor: borderColorBase,
    // );
    // rateStyle = _defaultRateStyle.merge(rateStyle);
    //
    // EImageCropStyle _defaultImageCropStyle = EImageCropStyle(
    //   borderColor: const Color(0xFFFFFFFF),
    //   borderWidget: 1,
    //   borderRadius: 0,
    // );
    // imageCropStyle = _defaultImageCropStyle.merge(imageCropStyle);
    // dropdownStyle = dropdownStyle ?? EDropdownStyle();
    // pageViewStyle = pageViewStyle ?? EPageViewStyle();
    //
    // EDialogStyle _defaultDialogStyle = EDialogStyle(
    //   backgroundColor: backgroundColorWhite,
    //   borderColor: borderColorBase,
    //   borderRadius: BorderRadius.all(Radius.circular(borderRadiusBase)),
    // );
    // dialogStyle = _defaultDialogStyle.merge(dialogStyle);

    return EleThemeData.raw(
      primaryColor: primaryColor,
      primaryTextColor: primaryTextColor,
      regularTextColor: regularTextColor,
      secondaryTextColor: secondaryTextColor,
      placeholderColor: placeholderColor,
      borderColorBase: borderColorBase,
      borderColorLight: borderColorLight,
      borderColorLighter: borderColorLighter,
      borderColorExtraLight: borderColorExtraLight,
      backgroundColorBase: backgroundColorBase,
      backgroundColorWhite: backgroundColorWhite,
      backgroundColorBlack: backgroundColorBlack,
      borderRadiusBase: borderRadiusBase,
      borderStyle: borderStyle ?? EBorderStyle(),
      buttonStyle: buttonStyle ?? EButtonStyle(),
      imageStyle: imageStyle ?? EImageStyle(),
      radioStyle: radioStyle ?? ERadioStyle(),
      checkboxStyle: checkboxStyle ?? ECheckboxStyle(),
      textFieldStyle: textFieldStyle ?? ETextFieldStyle(),
      inputNumberStyle: inputNumberStyle ?? EInputNumberStyle(),
      switchStyle: switchStyle ?? ESwitchStyle(),
      sliderStyle: sliderStyle ?? ESliderStyle(),
      rateStyle: rateStyle ?? ERateStyle(),
      imageCropStyle: imageCropStyle ?? EImageCropStyle(),
      dropdownStyle: dropdownStyle ?? EDropdownStyle(),
      pageViewStyle: pageViewStyle ?? EPageViewStyle(),
      dialogStyle: dialogStyle ?? EDialogStyle(),
    );
  }

  /// primary color
  ///
  /// if is null,value is theme primaryColor
  final Color? primaryColor;

  /// primary text color
  final Color? primaryTextColor;
  final Color? regularTextColor;
  final Color? secondaryTextColor;
  final Color? placeholderColor;

  /// one level border color
  final Color? borderColorBase;

  /// two level border color
  final Color? borderColorLight;

  /// three level border color
  final Color? borderColorLighter;

  /// four level border color
  final Color? borderColorExtraLight;

  /// backgroundColorBase
  final Color? backgroundColorBase;

  final Color? backgroundColorWhite;

  final Color? backgroundColorBlack;
  final double? borderRadiusBase;

  /// border theme data
  final EBorderStyle? borderStyle;

  /// button theme data
  final EButtonStyle? buttonStyle;

  /// image theme
  final EImageStyle? imageStyle;

  final ERadioStyle? radioStyle;
  final ECheckboxStyle? checkboxStyle;
  final ETextFieldStyle? textFieldStyle;
  final EInputNumberStyle? inputNumberStyle;
  final ESwitchStyle? switchStyle;
  final ESliderStyle? sliderStyle;
  final ERateStyle? rateStyle;
  final EImageCropStyle? imageCropStyle;
  final EDropdownStyle? dropdownStyle;
  final EPageViewStyle? pageViewStyle;
  final EDialogStyle? dialogStyle;

  factory EleThemeData.light() => EleThemeData();

  EleThemeData merge({
    Color? primaryColor,
    Color? primaryTextColor,
    Color? regularTextColor,
    Color? secondaryTextColor,
    Color? placeholderColor,
    Color? borderColorBase,
    Color? borderColorLight,
    Color? borderColorLighter,
    Color? borderColorExtraLight,
    Color? backgroundColorBase,
    Color? backgroundColorWhite,
    Color? backgroundColorBlack,
    double? borderRadiusBase,
    EBorderStyle? borderStyle,
    EButtonStyle? buttonStyle,
    EImageStyle? imageStyle,
    ERadioStyle? radioStyle,
    ECheckboxStyle? checkboxStyle,
    ETextFieldStyle? textFieldStyle,
    EInputNumberStyle? inputNumberStyle,
    ESwitchStyle? switchStyle,
    ESliderStyle? sliderStyle,
    ERateStyle? rateStyle,
    EImageCropStyle? imageCropStyle,
    EDropdownStyle? dropdownStyle,
    EPageViewStyle? pageViewStyle,
    EDialogStyle? dialogStyle,
  }) {
    return EleThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      regularTextColor: regularTextColor ?? this.regularTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      borderColorBase: borderColorBase ?? this.borderColorBase,
      borderColorLight: borderColorLight ?? this.borderColorLight,
      borderColorLighter: borderColorLighter ?? this.borderColorLighter,
      borderColorExtraLight:
          borderColorExtraLight ?? this.borderColorExtraLight,
      backgroundColorBase: backgroundColorBase ?? this.backgroundColorBase,
      backgroundColorWhite: backgroundColorWhite ?? this.backgroundColorWhite,
      backgroundColorBlack: backgroundColorBlack ?? this.backgroundColorBlack,
      borderRadiusBase: borderRadiusBase ?? this.borderRadiusBase,
      borderStyle: borderStyle ?? this.borderStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      imageStyle: imageStyle ?? this.imageStyle,
      radioStyle: radioStyle ?? this.radioStyle,
      checkboxStyle: checkboxStyle ?? this.checkboxStyle,
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
      inputNumberStyle: inputNumberStyle ?? this.inputNumberStyle,
      switchStyle: switchStyle ?? this.switchStyle,
      sliderStyle: sliderStyle ?? this.sliderStyle,
      rateStyle: rateStyle ?? this.rateStyle,
      imageCropStyle: imageCropStyle ?? this.imageCropStyle,
      dropdownStyle: dropdownStyle ?? this.dropdownStyle,
      pageViewStyle: pageViewStyle ?? this.pageViewStyle,
      dialogStyle: dialogStyle ?? this.dialogStyle,
    );
  }
}
