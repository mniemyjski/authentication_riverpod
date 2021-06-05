import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/screens/screens.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/custom_drawer/widget/header.dart';
import 'package:authentication_riverpod/widgets/custom_drawer/widget/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Header(),
          Item(
            icon: Icons.home,
            text: Languages.home(),
            onTap: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
          ),
          Item(
            icon: Icons.settings,
            text: Languages.settings(),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          Divider(),
          Item(
            icon: FontAwesomeIcons.question,
            text: Languages.help(),
            onTap: () {},
          ),
          Item(
            icon: Icons.exit_to_app,
            text: Languages.sign_out(),
            onTap: () {
              context.read(providerAuthController.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
