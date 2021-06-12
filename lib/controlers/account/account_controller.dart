import 'dart:async';

import 'package:authentication_riverpod/controlers/account/account_state.dart';
import 'package:authentication_riverpod/controlers/controllers.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerAccountController = StateNotifierProvider.autoDispose<AccountController, AccountState>(
  (ref) => AccountController(ref.read, ref.watch(providerAuthState).data?.value?.uid),
);

class AccountController extends StateNotifier<AccountState> {
  final Reader _read;
  final String? _uid;
  late StreamSubscription<Account?>? _subscription;

  AccountController(this._read, this._uid) : super(AccountState.initial()) {
    if (_uid != null) {
      _subscription = _read(providerAccountRepository).streamMyAccount(_uid!).listen((account) {
        account != null
            ? state = state.copyWith(
                account: account,
                state: ETypeAccountState.created,
              )
            : state = state.copyWith(
                state: ETypeAccountState.uncreated,
              );
      });
    } else {
      state = AccountState.initial();
    }
  }

  @override
  void dispose() {
    try {
      _subscription?.cancel();
    } catch (_) {}
    super.dispose();
  }

  void updateName(String name) {
    _read(providerAccountRepository).updateAccount(state.account!.copyWith(name: name));
  }

  void updateAvatar(String url) {
    _read(providerAccountRepository).updateAccount(state.account!.copyWith(photoUrl: url));
  }
}
