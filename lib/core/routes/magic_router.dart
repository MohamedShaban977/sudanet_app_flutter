import 'package:flutter/material.dart';

import 'route_animation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic> _materialPageRoute(page) =>
    MaterialPageRoute(builder: (_) => page);

Route<dynamic> _materialPageRouteAnimation(page) => RouteAnimation(page: page);

class MagicRouter {
  static final BuildContext? currentContext = navigatorKey.currentContext;

  static Route<dynamic> pageRoute(page) => _materialPageRoute(page);

  static Future<dynamic> navigateTo(Widget page) =>
      navigatorKey.currentState!.push(_materialPageRoute(page));

  static Future<dynamic> navigateReplacementTo(Widget page) =>
      navigatorKey.currentState!.pushReplacement(_materialPageRoute(page));

  static Future<dynamic> navigateAndPopAll(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        _materialPageRoute(page),
        (_) => false,
      );

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
          _materialPageRoute(page), (route) => route.isFirst);

  static void pop([dynamic result]) => navigatorKey.currentState!.pop(result);

  ///___________________________________________________________________________
  /// Named
}

class MagicRouterName {
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) =>
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);

  static Future<dynamic> navigateReplacementTo(String routeName,
          {Object? result, Object? arguments}) =>
      navigatorKey.currentState!.pushReplacementNamed(routeName,
          arguments: arguments, result: result);

  static Future<dynamic> navigateAndPopAll(String routeName) =>
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (_) => false);

  static Future<dynamic> navigateAndPopUntilFirstPage(String routeName,
          {Object? arguments}) =>
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (route) => route.isFirst,
        arguments: arguments,
      );

  static void popAndPush(String routeName,
          {Object? result, Object? arguments}) =>
      navigatorKey.currentState!
          .popAndPushNamed(routeName, result: result, arguments: arguments);

  static void pop([dynamic result]) => navigatorKey.currentState!.pop(result);
}
