import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/screens/screens.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class Log extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    Logger().v("{\nprovider: ${provider.name ?? provider.runtimeType}\n,newValue: $newValue\n}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = false;
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
      ],
      path: 'resources/languages.csv',
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: CsvAssetLoader(),
      fallbackLocale: Locale('pl'),
      child: ProviderScope(observers: [Log()], child: MyApp())));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final model = watch(providerPreferenceController);

      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Georgia',
          primarySwatch: Colors.indigo,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: (model.preference?.darkMode ?? false) ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: CustomRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      );
    });
  }
}
