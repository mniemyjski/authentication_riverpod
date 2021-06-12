import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/screens/profile/controller/profile_controller.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_controller.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileCreateScreen extends StatefulWidget {
  const ProfileCreateScreen({Key? key}) : super(key: key);
  static const String routeName = '/account-create';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => ProfileCreateScreen(),
    );
  }

  @override
  _ProfileCreateScreenState createState() => _ProfileCreateScreenState();
}

class _ProfileCreateScreenState extends State<ProfileCreateScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final GlobalKey<FormState> _formKeyName = GlobalKey();

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read(providerAuthController.notifier).delete();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.create_account()),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKeyName,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: Languages.name()),
                    textInputAction: TextInputAction.done,
                    controller: _controllerName,
                    validator: (v) => Validators.name(context, v),
                  ),
                ),
              ),
              CustomButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Languages.create_account()),
                    ],
                  ),
                  onPressed: () {
                    if (_formKeyName.currentState!.validate()) {
                      context.read(providerProfileController.notifier).changeValue(_controllerName.text);
                      context.read(providerProfileController.notifier).createAccount();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
