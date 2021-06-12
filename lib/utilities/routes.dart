import 'package:authentication_riverpod/screens/account/profile_create_screen.dart';
import 'package:authentication_riverpod/screens/introduction/introduction_screen.dart';
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
      case ProfileCreateScreen.routeName:
        return ProfileCreateScreen.route();
      case HomeScreen.routeName:
        final args = settings.arguments as bool?;
        return HomeScreen.route(args ?? false);
      case ProfileEditScreen.routeName:
        return ProfileEditScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case IntroScreen.routeName:
        return IntroScreen.route();
      case CropImageScreen.routeName:
        final args = settings.arguments as CropScreenArguments;
        return CropImageScreen.route(args);
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
