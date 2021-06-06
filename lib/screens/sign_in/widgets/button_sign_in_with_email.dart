import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_state.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_controller.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonSignInWithEmail extends StatelessWidget {
  const ButtonSignInWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FaIcon(
              Icons.mail,
              size: 40,
              color: Colors.white,
            ),
            Text(Languages.sign_in_with_email()),
            Container(),
          ],
        ),
        onPressed: () {
          context.read(providerSignInController.notifier).changeFormType(ETypeSignInForm.signIn);
        });
  }
}
