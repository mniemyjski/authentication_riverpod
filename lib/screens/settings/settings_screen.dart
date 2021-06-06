import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:authentication_riverpod/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SettingsScreen(),
    );
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.settings()),
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Consumer(builder: (context, watch, child) {
            final model = watch(providerPreferenceController);

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomDropDownButton(
                  name: Languages.locale_app(),
                  value: model.preference!.localeApp,
                  list: <String>['pl', 'en'],
                  onChanged: (String? state) {
                    setState(() {
                      context.setLocale(Locale(state!));
                    });

                    Preference pref = context.read(providerPreferenceController).preference!.copyWith(localeApp: state);
                    context.read(providerPreferenceController.notifier).updatePreference(pref);
                  },
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Switch(
                        value: model.preference!.darkMode,
                        onChanged: (state) {
                          Preference pref = context.read(providerPreferenceController).preference!.copyWith(darkMode: state);
                          context.read(providerPreferenceController.notifier).updatePreference(pref);
                        },
                      ),
                      Text(Languages.dark_mode()),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
