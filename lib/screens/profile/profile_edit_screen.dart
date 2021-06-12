import 'dart:typed_data';

import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:authentication_riverpod/screens/crop/crop_screen.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);
  static const String routeName = '/account-edit';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ProfileEditScreen(),
    );
  }

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final GlobalKey<FormState> _formKeyName = GlobalKey();

  @override
  void initState() {
    _controllerName.text = context.read(providerAccountController).account!.name;
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.edit_profile()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer(builder: (context, watch, child) {
              final model = watch(providerAccountController);
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => _changeImage(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomAvatar(url: model.account?.photoUrl ?? ''),
                    ),
                  ),
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
                ],
              );
            }),
            CustomButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Languages.save()),
                  ],
                ),
                onPressed: () => _save(key: _formKeyName, context: context, name: _controllerName.text)),
          ],
        ),
      ),
    );
  }
}

_changeImage(BuildContext context) async {
  final picker = ImagePicker();
  final result = await picker.getImage(
    source: ImageSource.gallery,
    imageQuality: 50,
    maxWidth: 1080,
    maxHeight: 1920,
  );

  if (result != null) {
    Uint8List uint8List = await result.readAsBytes();
    var image = await Navigator.pushNamed(
      context,
      CropImageScreen.routeName,
      arguments: CropScreenArguments(uint8List: uint8List, isCircleUi: true),
    );
    if (image != null) {
      String url = await context.read(providerStorageRepositories).uploadToFirebaseStorage(
            uint8List: image as Uint8List,
            folderName: Path.accounts(),
            name: '',
          );
      context.read(providerAccountController.notifier).updateAvatar(url);
    }
  }
}

_save({required GlobalKey<FormState> key, required BuildContext context, required String name}) async {
  FocusScope.of(context).unfocus();

  if (context.read(providerAccountController).account!.name == name) {
    Navigator.pop(context);
    return;
  }

  if (key.currentState!.validate()) {
    bool available = await context.read(providerAccountRepository).nameAvailable(name);

    if (!available) {
      customFlashBar(context, Languages.name_not_available());
      return;
    }

    context.read(providerAccountController.notifier).updateName(name);
    Navigator.pop(context);
  }
}
