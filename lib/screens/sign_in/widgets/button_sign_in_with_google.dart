import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_state.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_controller.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSignInWithGoogle extends StatelessWidget {
  const ButtonSignInWithGoogle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        textColor: Colors.black87,
        backgroundColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(Constants.resources_google()),
            ),
            Text(
              Languages.sign_in_with_google(),
              style: TextStyle(color: Colors.black87),
            ),
            Container(),
          ],
        ),
        onPressed: () => context.read(providerSignInController.notifier).signInWithGoogle());
  }
}
