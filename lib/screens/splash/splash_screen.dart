import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/controlers/auth/auth_state.dart';
import 'package:authentication_riverpod/screens/account/profile_create_screen.dart';
import 'package:authentication_riverpod/screens/home/home_screen.dart';
import 'package:authentication_riverpod/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<AuthState>(
        provider: providerAuthController,
        onChange: (context, model) {
          if (model.state == ETypeAuthState.uncreated) {
            Navigator.pushNamed(context, ProfileCreateScreen.routeName);
          }
          if (model.state == ETypeAuthState.created) {
            Navigator.pushNamed(context, HomeScreen.routeName, arguments: true);
          }

          if (model.state == ETypeAuthState.unauthenticated) {
            Navigator.pushNamed(context, SignInScreen.routeName);
          }
        },
        child: Scaffold(
          body: Center(
            child: const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            )),
          ),
        ));
  }
}
