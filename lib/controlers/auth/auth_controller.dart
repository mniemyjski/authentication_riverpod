import 'dart:async';

import 'package:authentication_riverpod/controlers/auth/auth_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAuthController = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref.read),
);

class AuthController extends StateNotifier<AuthState> {
  final Reader _read;
  late StreamSubscription<User?> _userSubscription;
  late StreamSubscription<Account?> _accountSubscription;

  AuthController(this._read) : super(AuthState.unknown()) {
    _userSubscription = _read(providerAuthRepository).user.listen((user) {
      if (user != null) {
        _accountSubscription = _read(providerAccountRepository).streamMyAccount(user.uid).listen((account) {
          account != null ? state = AuthState.created(user: user) : state = AuthState.uncreated(user: user);
        });
      }
      {
        state = AuthState.unauthenticated();
      }
    });
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  void signOut() {
    _read(providerAuthRepository).signOut();
  }
}
