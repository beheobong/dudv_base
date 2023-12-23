import 'package:flutter/material.dart';

mixin Styles {
  static const double spacingGrid = 15;
  static String font = 'Roboto';
  static FontWeight fontWeight = FontWeight.normal;
  static const double sizeFont = 14;
  static const Color bg4 = Color(0xff1A1A1A);
  static const double sizeHorizontal = 20;

  static const double borderRadius = 4;

  static EdgeInsets padding = const EdgeInsets.symmetric(vertical: 15);

  static BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
  );

  static TextStyle copyStyle({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
    String? fontFamily,
  }) =>
      TextStyle(
          fontSize: fontSize ?? sizeFont,
          color: color ?? colorDefault,
          fontWeight: fontWeight ?? fontWeight,
          decoration: decoration ?? TextDecoration.none,
          fontFamily: fontFamily ?? font,
          fontStyle: fontStyle,
          height: height ?? txHeight,
          letterSpacing: letterSpacing);

  static const Color gray3 = Color(0xffc2c2c2);
  static const Color mainRed = Color(0xffed1c24);
  static const Color mainBlue4 = Color(0xffa9ddff);

  static TextStyle appBar({Color? color}) => copyStyle(
      fontSize: fontSizeAppBar,
      color: color ?? colorDefault,
      fontWeight: FontWeight.bold);

  static TextStyle cusText({Color? color, double? size}) => copyStyle(
        fontSize: size ?? 14,
        color: color ?? Colors.white,
        fontWeight: FontWeight.w600,
      );
  static TextStyle errorStyle({
    Color? color,
    double? fontSize,
    double? letterSpacing,
  }) =>
      copyStyle(
          fontSize: fontSize ?? 11,
          color: color ?? Styles.red2,
          letterSpacing: letterSpacing ?? -0.5);

  static double fontSizeAppBar = 18;
  static Color colorDefault = black2;
  static double txHeight = 1;

  static void config({
    Color? color,
    double? sizeAppBar,
    String? fontFamily,
    double? height,
    FontWeight? weight,
  }) {
    if (color != null) {
      colorDefault = color;
    }
    if (sizeAppBar != null) {
      fontSizeAppBar = sizeAppBar;
    }
    if (fontFamily != null) {
      font = fontFamily;
    }
    if (height != null) {
      txHeight = height;
    }
    if (weight != null) {
      fontWeight = weight;
    }
  }

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    const lowDivisor = 6;
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

  static const Color colorMain = Color(0xffFC9220);
  static const Color colorMain2 = Color(0xffFFEEDC);
  static const Color blue = Color(0xff3D9AE2);
  static const Color blue2 = Color(0xFFBBDEFB);
  static const Color blue3 = Color(0xff324C81);
  static const Color blue4 = Color(0xff0092C9);
  static const Color blue5 = Color(0xff3B5998);
  static const Color blue6 = Color(0xff00ACED);
  static const Color blue7 = Color(0xff5D8FFC);
  static const Color blue8 = Color(0xFF444B8C);

  static const Color red = Color(0xffCF392E);
  static const Color red2 = Color(0xffFF0000);
  static const Color red3 = Color(0xffe53935);
  static const Color red4 = Color(0xffFF0B00);
  static const Color red5 = Color(0xFFE57373);
  static const Color red6 = Color(0xffBB5553);
  static const Color red7 = Color(0xffFF3300);

  static const Color green = Color(0xff00A500);
  static const Color green2 = Color(0xff00C200);
  static const Color green3 = Color(0xff0CCF00);
  static const Color green4 = Color(0xff38D05B);
  static const Color green5 = Color(0xFF75BB38);
  static const Color green6 = Color(0xff2ED150);

  static const Color colorbgImg = Color(0xff52B0A5);

  static const Color orange = Color(0xffFD9400);
  static const Color colorStar = Color(0xffF8AD00);
  static const Color orange1 = Color(0xFFFFF9F2);
  static const Color orange2 = Color(0xffFFF7EE);

  static const Color tv = Color(0xff77757A);
  static const Color black = Color(0xff333333);
  static const Color black2 = Color(0xff565454);
  static const Color black3 = Color(0xff404040);
  static const Color black4 = Color(0xff222222);
  static const Color black5 = Color(0xff575757);
  static const Color black6 = Color(0xff565656);
  static const Color black7 = Color(0xff4B4B4B);
  static const Color black8 = Color(0xff484848);
  static const Color black9 = Color(0xff666464);

  static const Color grey = Color(0xffF2F2F2);
  static const Color grey2 = Color(0x8A000000);
  static const Color grey3 = Color(0xFFF5F5F5);
  static const Color grey4 = Color(0xFFE1E1E1);
  static const Color grey6 = Color(0xFFE0E3E5);
  static const Color grey7 = Color(0xff999A9B);
  static const Color grey8 = Color(0xff8E8E8E);
  static const Color grey9 = Color(0xff96A7AF);
  static const Color grey10 = Color(0xffB8C2C0);
  static const Color grey11 = Color(0xFFC1C1C1);
  static const Color grey12 = Color(0xffD9DBE0);
  static const Color grey13 = Color(0xFFF7F8FA);
  static const Color grey14 = Color(0xFFD8D8D8);
  static const Color grey15 = Color(0xFFF1F1F1);
  static const Color grey16 = Color(0xffECECEC);
  static const Color grey17 = Color(0xffAFAFAF);
  static const Color grey18 = Color(0xffB1B1B1);
  static const Color grey19 = Color(0xff9B9B9B);
  static const Color grey20 = Color(0xff666666);
  static const Color grey21 = Color(0xffC6C3BD);
  static const Color grey22 = Color(0xffAEAEAE);
  static const Color grey23 = Color(0xff656565);
  static const Color grey24 = Color(0xFFBEC1C5);
  static const Color grey25 = Color(0xFFB7B7B7);
  static const Color grey26 = Color(0xffFFFFFF);
  static const Color grey27 = Color(0xffdbdbdb);
  static const Color grey28 = Color(0xffABABAB);
  static const Color grey29 = Color(0xffD9D9D9);
  static const Color grey30 = Color(0xff8b8888);
  static const Color grey31 = Color(0xff9f9f9f);
  static const Color grey32 = Color(0xffc8c8c8);
  static const Color grey33 = Color(0xffE5E5E5);
  static const Color grey34 = Color(0xffAAAAAA);
  static const Color grey35 = Color(0xffB8B8B8);
  static const Color grey36 = Color(0xffC5C5C5);
  static const Color grey37 = Color(0xffCCCCCC);
  static const Color grey38 = Color(0xff3D4C69);
  static const Color grey39 = Color(0xffE4E4E4);
  static const Color grey40 = Color(0xffE9E9E9);
  static const Color grey41 = Color(0xffF6F6F6);
  static const Color grey42 = Color(0xffC2C2C2);
  static const Color grey43 = Color(0xffDCDCDC);
  static const Color grey44 = Color(0xffACACAC);
  static const Color grey45 = Color(0xff707070);
  static const Color grey46 = Color(0xff595959);
  static const Color clLine = Color(0xffDFDFDF);

  static const Color appbarBg = Color(0xff6A6A6A);
  static const Color clTime = Color(0xffB2B2B2);
  static const Color grey49 = Color(0xffC2C2C2);

  static const Color grey47 = Color(0xffF9F9F9);

  static const Color grey48 = Color(0xff8A8A8A);

  static const Color grey50 = Color(0xffA2A3A4);
  static const Color grey51 = Color(0xffE7E7E7);
  static const Color grey52 = Color(0xff929699);
  static const Color grey53 = Color(0xffE8E8E8);
  static const Color grey54 = Color(0xffA5A5A5);
  static const Color grey55 = Color(0xff595959);
  static const Color grey56 = Color(0xffE2E2E2);
  static const Color grey57 = Color(0xff9C9C9C);
  static const Color bg = Color(0xffF0F2F5);
}
