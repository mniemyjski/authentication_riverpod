import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:authentication_riverpod/screens/account/controller/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerProfileController = StateNotifierProvider<ProfileController, ProfileState>(
  (ref) => ProfileController(ref.read),
);

class ProfileController extends StateNotifier<ProfileState> {
  final Reader _read;
  ProfileController(this._read) : super(ProfileState.initial());

  void createAccount() async {
    final User? user = _read(providerAuthController).user;

    if (user != null) {
      Account account = state.account.copyWith(uid: user.uid, photoUrl: user.photoURL);
      _read(providerAccountRepository).createAccount(account);
      _read(providerPreferenceRepository).createPreference(Preference(darkMode: false, localeApp: 'pl'), user.uid);
    }
  }

  void changeValue(String name) {
    state = ProfileState(account: Account(name: name));
  }
}
