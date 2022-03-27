import 'package:flutter/material.dart';

abstract class FontFamily {
  static const String raleway = "Raleway";
}

abstract class AppStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 109.66,
    color: Colors.white,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 67.77,
    color: Colors.white,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 41.89,
    color: Colors.white,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 25.89,
    color: Colors.white,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: FontFamily.raleway,
    fontSize: 12,
    color: Colors.white,
  );
}
