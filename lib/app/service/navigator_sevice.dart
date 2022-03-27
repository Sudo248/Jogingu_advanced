import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  Future<T?> navigateTo<T extends Object?>(String routeName,
          {Object? arguments}) =>
      navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);

  void back<T extends Object?>([T? result]) => navigatorKey.currentState!.pop<T>(result);

  Future navigateOff(String routeName, {Object? arguments}) =>
      navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);

  Future navigateOffAll(String routeName, {Object? arguments}) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false,
          arguments: arguments);
}
