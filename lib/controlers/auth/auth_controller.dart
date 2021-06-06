import 'dart:async';

import 'package:authentication_riverpod/controlers/account/account_controller.dart';
import 'package:authentication_riverpod/controlers/account/account_state.dart';
import 'package:authentication_riverpod/controlers/auth/auth_state.dart';
import 'package:authentication_riverpod/controlers/connectivity/connectivity_controller.dart';
import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/controlers/preference/preference_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerAuthController = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref.read),
);

class AuthController extends StateNotifier<AuthState> {
  final Reader _read;
  late StreamSubscription<User?> _userSubscription;
  late StreamSubscription<Account?> _accountSubscription;
  late StreamSubscription<Preference?> _preferenceSubscription;

  AuthController(this._read) : super(AuthState.initial()) {
    _userSubscription = _read(providerAuthRepository).userChanges.listen((user) {
      if (user != null) {
        _accountSubscription = _read(providerAccountRepository).streamMyAccount(user.uid).listen((account) {
          _preferenceSubscription = _read(providerPreferenceRepository).streamPreference(user.uid).listen((preference) {
            if (account != null && preference != null) {
              AuthState newState = state.copyWith(user: user, state: ETypeAuthState.created);
              if (state.state != newState.state) {
                state = newState;
              }
            } else {
              state = state.copyWith(
                user: user,
                state: ETypeAuthState.uncreated,
              );
            }
          });
        });
      } else {
        state = state.copyWith(state: ETypeAuthState.unauthenticated);
      }
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _accountSubscription.cancel();
    _preferenceSubscription.cancel();
    super.dispose();
  }

  void signOut() {
    _read(providerAuthRepository).signOut();
  }

  void delete() {
    _read(providerAuthRepository).delete();
  }
}
