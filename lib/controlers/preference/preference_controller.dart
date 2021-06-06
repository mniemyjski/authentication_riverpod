import 'dart:async';

import 'package:authentication_riverpod/controlers/preference/preference_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerPreferenceController = StateNotifierProvider<PreferenceController, PreferenceState>(
  (ref) => PreferenceController(ref.read),
);

class PreferenceController extends StateNotifier<PreferenceState> {
  final Reader _read;
  late StreamSubscription<Preference?> _subscription;
  late StreamSubscription<User?> _userSubscription;
  late String _uid;

  PreferenceController(this._read) : super(PreferenceState.initial()) {
    _userSubscription = _read(providerAuthRepository).userChanges.listen((user) {
      if (user != null) {
        _uid = user.uid;
        _subscription = _read(providerPreferenceRepository).streamPreference(_uid).listen((preference) {
          preference != null
              ? state = state.copyWith(
                  preference: preference,
                  state: ETypePreferenceState.created,
                )
              : state = state.copyWith(
                  state: ETypePreferenceState.uncreated,
                );
        });
      }
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _subscription.cancel();

    super.dispose();
  }

  void createPreference(Preference preference) {
    _read(providerPreferenceRepository).createPreference(Preference(darkMode: false, localeApp: 'pl'), _uid);
  }

  void updatePreference(Preference preference) {
    _read(providerPreferenceRepository).updatePreference(preference, _uid);
  }
}
