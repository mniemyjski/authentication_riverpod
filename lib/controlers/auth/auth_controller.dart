import 'dart:async';

import 'package:authentication_riverpod/controlers/auth/auth_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerAuthController = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref.read, ref.watch(providerAuthState).data?.value),
);

final providerAuthState = StreamProvider<User?>((ref) => ref.watch(providerAuthRepository).authStateChanges());

class AuthController extends StateNotifier<AuthState> {
  final Reader _read;
  final User? user;
  late StreamSubscription<Account?>? _accountSubscription;
  late StreamSubscription<Preference?>? _preferenceSubscription;

  AuthController(this._read, this.user) : super(AuthState.initial()) {
    if (user != null) {
      state = AuthState(user: user);
      _accountSubscription = _read(providerAccountRepository).streamMyAccount(user!.uid).listen((account) {
        _preferenceSubscription = _read(providerPreferenceRepository).streamPreference(user!.uid).listen((preference) {
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
      state = AuthState(state: ETypeAuthState.unauthenticated);
    }
  }

  @override
  void dispose() {
    try {
      _accountSubscription!.cancel();
      _preferenceSubscription!.cancel();
    } catch (_) {}
    super.dispose();
  }

  void signOut() {
    _read(providerAuthRepository).signOut();
  }

  void delete() {
    _read(providerAuthRepository).delete();
  }
}
