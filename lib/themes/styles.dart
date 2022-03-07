import 'package:flutter/material.dart';

mixin Styles {
  static final double spacingGrid = 15;
  static final String font = 'Roboto';
  static final double sizeFont = 14;
  static final Color bg4 = Color(0xff1A1A1A);
  static final double sizeHorizontal = 20; 

  static final double borderRadius = 4;

  static EdgeInsets padding = EdgeInsets.symmetric(vertical: 15);

  static BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4),
  );

  static TextStyle copyStyle({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
          fontSize: fontSize ?? sizeFont,
          color: color ?? black2,
          fontWeight: fontWeight,
          decoration: decoration ?? TextDecoration.none,
          fontFamily: font,
          fontStyle: fontStyle,
          height: height ?? 1,
          letterSpacing: letterSpacing);

  static final Color gray3 = Color(0xffc2c2c2);
  static final Color mainRed = Color(0xffed1c24);
  static final Color mainBlue4 = Color(0xffa9ddff);

  static TextStyle appBar({Color? color}) => copyStyle(
      fontSize: 18, color: color ?? black2, fontWeight: FontWeight.bold);

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

  static final Color colorMain = Color(0xffFC9220);
  static final Color colorMain2 = Color(0xffFFEEDC);
  static final Color blue = Color(0xff3D9AE2);
  static final Color blue2 = Color(0xFFBBDEFB);
  static final Color blue3 = Color(0xff324C81);
  static final Color blue4 = Color(0xff0092C9);
  static final Color blue5 = Color(0xff3B5998);
  static final Color blue6 = Color(0xff00ACED);
  static final Color blue7 = Color(0xff5D8FFC);
  static final Color blue8 = Color(0xFF444B8C);

  static final Color red = Color(0xffCF392E);
  static final Color red2 = Color(0xffFF0000);
  static final Color red3 = Color(0xffe53935);
  static final Color red4 = Color(0xffFF0B00);
  static final Color red5 = Color(0xFFE57373);
  static final Color red6 = Color(0xffBB5553);
  static final Color red7 = Color(0xffFF3300);

  static final Color green = Color(0xff00A500);
  static final Color green2 = Color(0xff00C200);
  static final Color green3 = Color(0xff0CCF00);
  static final Color green4 = Color(0xff38D05B);
  static final Color green5 = Color(0xFF75BB38);
  static final Color green6 = Color(0xff2ED150);

  static final Color colorbgImg = Color(0xff52B0A5);

  static final Color orange = Color(0xffFD9400);
  static final Color colorStar = Color(0xffF8AD00);
  static final Color orange1 = Color(0xFFFFF9F2);
  static final Color orange2 = Color(0xffFFF7EE);

  static final Color tv = Color(0xff77757A);
  static final Color black = Color(0xff333333);
  static final Color black2 = Color(0xff565454);
  static final Color black3 = Color(0xff404040);
  static final Color black4 = Color(0xff222222);
  static final Color black5 = Color(0xff575757);
  static final Color black6 = Color(0xff565656);
  static final Color black7 = Color(0xff4B4B4B);
  static final Color black8 = Color(0xff484848);
  static final Color black9 = Color(0xff666464);

  static final Color grey = Color(0xffF2F2F2);
  static final Color grey2 = Color(0x8A000000);
  static final Color grey3 = Color(0xFFF5F5F5);
  static final Color grey4 = Color(0xFFE1E1E1);
  static final Color grey6 = Color(0xFFE0E3E5);
  static final Color grey7 = Color(0xff999A9B);
  static final Color grey8 = Color(0xff8E8E8E);
  static final Color grey9 = Color(0xff96A7AF);
  static final Color grey10 = Color(0xffB8C2C0);
  static final Color grey11 = Color(0xFFC1C1C1);
  static final Color grey12 = Color(0xffD9DBE0);
  static final Color grey13 = Color(0xFFF7F8FA);
  static final Color grey14 = Color(0xFFD8D8D8);
  static final Color grey15 = Color(0xFFF1F1F1);
  static final Color grey16 = Color(0xffECECEC);
  static final Color grey17 = Color(0xffAFAFAF);
  static final Color grey18 = Color(0xffB1B1B1);
  static final Color grey19 = Color(0xff9B9B9B);
  static final Color grey20 = Color(0xff666666);
  static final Color grey21 = Color(0xffC6C3BD);
  static final Color grey22 = Color(0xffAEAEAE);
  static final Color grey23 = Color(0xff656565);
  static final Color grey24 = Color(0xFFBEC1C5);
  static final Color grey25 = Color(0xFFB7B7B7);
  static final Color grey26 = Color(0xffFFFFFF);
  static final Color grey27 = Color(0xff5DBDBDB);
  static final Color grey28 = Color(0xffABABAB);
  static final Color grey29 = Color(0xffD9D9D9);
  static final Color grey30 = Color(0xff8b8888);
  static final Color grey31 = Color(0xff9f9f9f);
  static final Color grey32 = Color(0xffc8c8c8);
  static final Color grey33 = Color(0xffE5E5E5);
  static final Color grey34 = Color(0xffAAAAAA);
  static final Color grey35 = Color(0xffB8B8B8);
  static final Color grey36 = Color(0xffC5C5C5);
  static final Color grey37 = Color(0xffCCCCCC);
  static final Color grey38 = Color(0xffF3D4C69);
  static final Color grey39 = Color(0xffE4E4E4);
  static final Color grey40 = Color(0xffE9E9E9);
  static final Color grey41 = Color(0xffF6F6F6);
  static final Color grey42 = Color(0xffC2C2C2);
  static final Color grey43 = Color(0xffDCDCDC);
  static final Color grey44 = Color(0xffACACAC);
  static final Color grey45 = Color(0xff707070);
  static final Color grey46 = Color(0xff595959);
  static final Color clLine = Color(0xffDFDFDF);

  static final Color appbarBg = Color(0xff6A6A6A);
  static final Color clTime = Color(0xffB2B2B2);
  static final Color grey49 = Color(0xffC2C2C2);

  static final Color grey47 = Color(0xffF9F9F9);

  static final Color grey48 = Color(0xff8A8A8A);

  static final Color grey50 = Color(0xffA2A3A4);
  static final Color grey51 = Color(0xffE7E7E7);
  static final Color grey52 = Color(0xff929699);
  static final Color grey53 = Color(0xffE8E8E8);
  static final Color grey54 = Color(0xffA5A5A5);
  static final Color grey55 = Color(0xff595959);
  static final Color grey56 = Color(0xffE2E2E2);
  static final Color grey57 = Color(0xff9C9C9C);
}
