
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'Sana',
  primaryColor: MyColors.primary,
  scaffoldBackgroundColor: MyColors.backgroundPage,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.containerColor
  ),
  textTheme: TextTheme(
    headline1: MyTextStyles.title1,
    bodyText1: MyTextStyles.body,
    bodyText2: MyTextStyles.body,
  ),
  hoverColor: MyColors.hover,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.white,
  ),
  unselectedWidgetColor: MyColors.primary,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: MyColors.primary,
      textStyle: MyTextStyles.buttonText,
      shape: RoundedRectangleBorder(
        borderRadius: MyShapes.circularBorders
      ),
    )
  ),
  inputDecorationTheme: InputDecorationTheme(
        fillColor: MyColors.containerColor,
        hintStyle: MyTextStyles.formPlaceHolder,
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        border: InputBorder.none,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: MyColors.primary,
  ),
  iconTheme: IconThemeData(
    color: MyColors.iconColors
  ),
  buttonColor: MyColors.primary
);

class MyColors {
  static const Color backgroundPage = const Color(0xff282828);
  static const Color primary = const Color(0xff46e288);
  static const Color hover = const Color(0xff00e25e);
  static const Color containerColor = const Color(0xff474747);
  static const Color bodyText = const Color(0xffc4c4c4);
  static const Color iconColors = const Color(0xff808080);
}

class MyTextStyles {
  static const TextStyle title1 = const TextStyle(
    fontFamily: 'PureBold',
    fontSize: 34,
    color: const Color(0xffffffff),
    letterSpacing: 1.5,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle body = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 18,
    color: const Color(0xffc4c4c4),
  );
  static const TextStyle formPlaceHolder = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 21,
    color: const Color(0xff898989),
    shadows: [
      Shadow(
        color: const Color(0x29000000),
        offset: Offset(0, 3),
        blurRadius: 6,
      )
    ],
  );
  static const TextStyle buttonText = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 21,
    color: Colors.white,
    shadows: [
      Shadow(
        color: const Color(0x29000000),
        offset: Offset(0, 3),
        blurRadius: 6,
      )
    ],
  );
  static const TextStyle bodyLink = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 18,
    color: const Color(0xff46e288),
  );
  static const TextStyle dateChatScreen = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 13,
    color: const Color(0xff717171),
  );
  static const TextStyle dateMessagesScreen = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 11,
    color: MyColors.bodyText,
  );

}

class MyShapes {

  static BorderRadiusGeometry circularBorders = BorderRadius.circular(38.0);
  static BorderRadiusGeometry checkboxBorders = BorderRadius.circular(4.0);
  static Radius radiusCircular = Radius.circular(38.0);
  static Radius radiusCircularZero = Radius.circular(0.0);

}

class MySizes {

  static double minimumHeightInputs = 55;

}