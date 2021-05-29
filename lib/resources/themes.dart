
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'Sana',
  primaryColor: MyColors.primary
);

class MyColors {
  static const Color backgroundPage = const Color(0xff282828);
  static const Color primary = const Color(0xff46e288);
  static const Color hover = const Color(0xff00e25e);
  static const Color containerColor = const Color(0xff474747);
  static const Color bodyText = const Color(0xffc4c4c4);
  static const Color iconColors = Color.fromRGBO(0,0,0,0.32);
}

class MyTextStyles {
  static const TextStyle title1 = const TextStyle(
    fontFamily: 'PureBold',
    fontSize: 40,
    color: const Color(0xffffffff),
    letterSpacing: -0.48,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle body = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 18,
    color: const Color(0xffc4c4c4),
    letterSpacing: -0.14,
  );
  static const TextStyle buttonPlaceHolder = const TextStyle(
    fontFamily: 'Sana',
    fontSize: 21,
    color: const Color(0xff898989),
    letterSpacing: -0.168,
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
    letterSpacing: -0.14,
  );
  static const TextStyle date = const TextStyle(
    fontFamily: 'Hiragino Sans',
    fontSize: 8,
    color: const Color(0xff717171),
  );

}