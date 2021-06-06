import 'dart:async';

import 'package:authentication_riverpod/controlers/account/account_state.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerAccountController = StateNotifierProvider<AccountController, AccountState>(
  (ref) => AccountController(ref.read),
);

class AccountController extends StateNotifier<AccountState> {
  final Reader _read;
  late StreamSubscription<Account?> _subscription;
  late StreamSubscription<User?> _userSubscription;
  late String _uid;

  AccountController(this._read) : super(AccountState.initial()) {
    _userSubscription = _read(providerAuthRepository).userChanges.listen((user) {
      if (user != null) {
        _uid = user.uid;
        _subscription = _read(providerAccountRepository).streamMyAccount(user.uid).listen((account) {
          account != null
              ? state = state.copyWith(
                  account: account,
                  state: ETypeAccountState.created,
                )
              : state = state.copyWith(
                  state: ETypeAccountState.uncreated,
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

  void crateAccount(Account account) {
    _read(providerAccountRepository).createAccount(account);
  }

  void updateName(String name) {
    _read(providerAccountRepository).updateAccount(state.account!.copyWith(name: name));
  }

  void updateAvatar(String url) {
    _read(providerAccountRepository).updateAccount(state.account!.copyWith(photoUrl: url));
  }
}
