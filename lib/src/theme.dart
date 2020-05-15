import 'package:flutter/material.dart';

final bgColor = new Color(0xFFF8F8FF);
final primaryColor = new Color(0xFF00094B);
final buttonPrimary = new Color(0xFF5E4AE7);
final successColor = new Color(0xFF48A9A6);
final dangerColor = new Color(0xFFB24C63);
final infoColor = new Color(0xFF357DED);
final warningColor = new Color(0xFFEDAE49);
final mutedColor = Colors.grey;

ThemeData makeDefaultTheme(context) {
  return new ThemeData(
    fontFamily: 'WorkSans',
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: primaryColor,
          displayColor: primaryColor,
        ),
  );
}

final pageTitleStyle = new TextStyle(
  fontWeight: FontWeight.w500,
  color: primaryColor,
  fontSize: 16,
);

final titleStyle = new TextStyle(
  fontWeight: FontWeight.bold,
  color: primaryColor,
  fontSize: 16,
);

final subtitleStyle = new TextStyle(
  color: mutedColor,
  fontSize: 14,
);

final subjectStyle = new TextStyle(
  fontWeight: FontWeight.w500,
  color: primaryColor,
  fontSize: 20,
);

final normalTextStyle = new TextStyle(
  fontWeight: FontWeight.normal,
  color: primaryColor,
  fontSize: 14,
);

final containerPadding =
    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0);
