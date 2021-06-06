import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/utilities/validators.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_state.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_controller.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKeyEmail = GlobalKey();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerSignInController);

      _controllerEmail.text = model.email;
      _controllerPassword.text = model.password;

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKeyEmail,
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: FaIcon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    controller: _controllerEmail,
                    validator: (v) => Validators.email(v),
                  ),
                ),
              ),
              if (model.formType != ETypeSignInForm.reset)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKeyPassword,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: FaIcon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      controller: _controllerPassword,
                      validator: (v) => Validators.password(v),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: CustomButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(
                          Icons.mail,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(_buttonName(model)),
                        Container(),
                      ],
                    ),
                    onPressed: () => _onPressedSignInOrRegister(model)),
              ),
              if (model.formType != ETypeSignInForm.reset)
                TextButton(
                    onPressed: () {
                      context.read(providerSignInController.notifier).changeFormType(ETypeSignInForm.reset);
                    },
                    child: Text(Languages.forgot_your_password())),
              if (model.formType != ETypeSignInForm.reset)
                TextButton(
                    onPressed: () => _onPressedChangeTypeForm(model),
                    child: Text(
                      model.formType == ETypeSignInForm.signIn ? Languages.need_register() : Languages.have_account_sign_in(),
                    )),
            ],
          ),
        ),
      );
    });
  }

  String _buttonName(SignInState model) {
    if (model.formType == ETypeSignInForm.signIn) return Languages.sign_in();
    if (model.formType == ETypeSignInForm.register) return Languages.create_account();
    return Languages.send();
  }

  void _onPressedChangeTypeForm(SignInState model) {
    if (model.formType == ETypeSignInForm.signIn) {
      context.read(providerSignInController.notifier).changeFormType(ETypeSignInForm.register);
    } else {
      context.read(providerSignInController.notifier).changeFormType(ETypeSignInForm.signIn);
    }
  }

  void _onPressedSignInOrRegister(SignInState model) async {
    Failure? failure;
    if (model.formType == ETypeSignInForm.reset && _formKeyEmail.currentState!.validate()) {
      context.read(providerSignInController.notifier).changeValue(email: _controllerEmail.text);
      failure = await context.read(providerSignInController.notifier).signInWithEmail();
      if (failure == null) customFlashBar(context, Languages.reset_mail());
    }

    if (model.formType != ETypeSignInForm.reset && _formKeyEmail.currentState!.validate() && _formKeyPassword.currentState!.validate()) {
      context.read(providerSignInController.notifier).changeValue(email: _controllerEmail.text, password: _controllerPassword.text);
      failure = await context.read(providerSignInController.notifier).signInWithEmail();
    }
    if (failure != null) customFlashBar(context, failure.message);
  }
}
