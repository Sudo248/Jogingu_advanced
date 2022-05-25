import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GlobalData {
  /// app context from GlobalKey<NavigatorState>.currentContext
  final BuildContext? appContext;

  GlobalData({required this.appContext});

  /// The window to which this binding is bound.
  ui.SingletonFlutterWindow get window => ui.window;

  ui.Locale? get deviceLocale => ui.window.locale;

  ///The number of device pixels for each logical pixel.
  double get pixelRatio => ui.window.devicePixelRatio;

  ui.Size get size => ui.window.physicalSize / pixelRatio;

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;

  ///The distance from the top edge to the first unpadded pixel,
  ///in physical pixels.
  double get statusBarHeight => ui.window.padding.top;

  ///The distance from the bottom edge to the first unpadded pixel,
  ///in physical pixels.
  double get bottomBarHeight => ui.window.padding.bottom;

  ///The system-reported text scale.
  double get textScaleFactor => ui.window.textScaleFactor;

  /// Screen size in real pixels
  double get widthPixels => ui.window.physicalSize.shortestSide;
  double get heightPixels => ui.window.physicalSize.longestSide;

  /// get app theme
  ThemeData get theme {
    ThemeData theme = ThemeData.fallback();
    if (appContext != null) {
      theme = Theme.of(appContext!);
    }
    return theme;
  }

  /// give access to TextTheme.of(context)
  TextTheme get textTheme => theme.textTheme;

  /// give access to Mediaquery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(appContext!);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// Check if dark mode theme is enable on platform on android Q+
  bool get isPlatformDarkMode =>
      (ui.window.platformBrightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  /// give access to FocusScope.of(context)
  FocusNode? get focusScope => FocusManager.instance.primaryFocus;
}
