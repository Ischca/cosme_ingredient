import 'package:flutter/cupertino.dart';

class AppTheme {
  static const Color _primaryColor = CupertinoColors.activeBlue;

  static const CupertinoThemeData lightTheme = CupertinoThemeData(
    primaryColor: _primaryColor,
    barBackgroundColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: CupertinoColors.black,
        fontSize: 14.0,
      ),
    ),
  );
}
