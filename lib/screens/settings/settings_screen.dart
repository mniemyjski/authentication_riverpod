import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = useProvider(providerPreferenceController);
    final darkMode = useProvider(providerDarkMode);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.settings()),
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomDropDownButton(
                name: Languages.locale_app(),
                value: context.locale.toString(),
                list: <String>['pl', 'en'],
                onChanged: (String? state) {
                  context.setLocale(Locale(state!));
                },
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Switch(
                      value: darkMode,
                      onChanged: (state) async {
                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                        context.read(providerDarkMode.notifier).change(state);
                        // await prefs.setBool('DarkMode', state);
                      },
                    ),
                    Text(Languages.dark_mode()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
