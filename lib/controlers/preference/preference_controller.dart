import 'dart:async';

import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/controlers/preference/preference_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerPreferenceController = StateNotifierProvider.autoDispose<PreferenceController, PreferenceState>(
  (ref) {
    return PreferenceController(
      ref.read,
      ref.watch(providerAuthState).data?.value?.uid,
    );
  },
);

class PreferenceController extends StateNotifier<PreferenceState> {
  final Reader _read;
  final String? _uid;

  late StreamSubscription<Preference?>? _subscription;

  PreferenceController(this._read, this._uid) : super(PreferenceState.initial()) {
    if (_uid != null) {
      _subscription = _read(providerPreferenceRepository).streamPreference(_uid!).listen((preference) {
        preference != null
            ? state = state.copyWith(
                preference: preference,
                state: ETypePreferenceState.created,
              )
            : state = state.copyWith(
                state: ETypePreferenceState.uncreated,
              );
      });
    } else {
      state = PreferenceState.initial();
    }
  }

  @override
  void dispose() {
    try {
      _subscription?.cancel();
    } catch (_) {}
    super.dispose();
  }

  void updatePreference(Preference preference) {
    _read(providerPreferenceRepository).updatePreference(preference, _uid!);
  }
}
