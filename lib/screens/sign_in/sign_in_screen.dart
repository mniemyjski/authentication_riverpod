import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_state.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_controller.dart';
import 'package:authentication_riverpod/screens/sign_in/widgets/button_sign_in_with_email.dart';
import 'package:authentication_riverpod/screens/sign_in/widgets/button_sign_in_with_google.dart';
import 'package:authentication_riverpod/screens/sign_in/widgets/email_form.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = '/sign-in';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer(
        builder: (context, watch, child) {
          final model = watch(providerSignInController);

          if (model.state != ETypeSignInState.initial)
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: (model.formType != ETypeSignInForm.initial)
                ? AppBar(
                    title: Text(_titleName(model)),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => context.read(providerSignInController.notifier).changeFormType(ETypeSignInForm.initial),
                    ))
                : null,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Text(
                    Constants.app_name(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                    ),
                  ),
                ),
                if (model.formType == ETypeSignInForm.initial) ButtonSignInWithGoogle(),
                if (model.formType == ETypeSignInForm.initial) ButtonSignInWithEmail(),
                if (model.formType != ETypeSignInForm.initial) EmailForm(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _titleName(SignInState model) {
    if (model.formType == ETypeSignInForm.signIn) return Languages.login();
    if (model.formType == ETypeSignInForm.register) return Languages.register();
    return Languages.reset_password();
  }
}
