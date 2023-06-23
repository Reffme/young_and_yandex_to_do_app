import 'package:flutter/material.dart';

class RouteLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navigated to: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navigated from: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      debugPrint('Navigated to: ${newRoute.settings.name}');
    }
    if (oldRoute != null) {
      debugPrint('Navigated from: ${oldRoute.settings.name}');
    }
  }
}
