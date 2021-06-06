import 'package:authentication_riverpod/controlers/account/account_controller.dart';
import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/controlers/auth/auth_state.dart';
import 'package:authentication_riverpod/screens/screens.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorDark.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProfileEditScreen.routeName);
            },
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 40.0,
                left: 16.0,
                child: Consumer(builder: (context, watch, child) {
                  final model = watch(providerAccountController);
                  return CustomAvatar(url: model.account?.photoUrl ?? '');
                }),
              ),
              Positioned(
                  bottom: 8.0,
                  left: 16.0,
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                  )),
            ]),
          )),
    );
  }
}
