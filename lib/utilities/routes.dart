import 'package:authentication_riverpod/screens/account/account_create_screen.dart';
import 'package:authentication_riverpod/screens/screens.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.arguments}');
    // final args = settings.arguments as HomeScreenArg;

    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case AccountCreateScreen.routeName:
        return AccountCreateScreen.route();
      case HomeScreen.routeName:
        final args = settings.arguments as bool?;
        return HomeScreen.route(args ?? false);
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
