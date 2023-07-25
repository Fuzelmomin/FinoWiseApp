

import 'package:fino_wise/screens/treads/ui/treads_screen.dart';
import 'package:flutter/material.dart';

import '../constants/app_screens.dart';
import '../screens/login/ui/login_screen.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppScreens.login:
        return _buildRoute(
          settings,
          LoginScreen.create(),
        );
      case AppScreens.treads:
        return _buildRoute(
          settings,
          TreadsScreen.create(),
        );

      default:
        return _buildRoute(settings, Container());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}