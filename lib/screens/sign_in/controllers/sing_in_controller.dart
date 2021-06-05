import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/repositories.dart';
import 'package:authentication_riverpod/screens/sign_in/controllers/sign_in_state.dart';
import 'package:authentication_riverpod/utilities/utilities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerSignInController = StateNotifierProvider<SignInController, SignInState>(
  (ref) => SignInController(ref.read),
);

class SignInController extends StateNotifier<SignInState> {
  final Reader _reader;
  SignInController(this._reader) : super(SignInState.initial());

  signInWithGoogle() async {
    state = state.copyWith(state: ESignInState.loading);
    try {
      await _reader(providerAuthRepository).signInWithGoogle();
      state = state.copyWith(state: ESignInState.success);
    } on Failure catch (e) {
      state = SignInState.initial();
      return e;
    }
  }

  signInWithEmail() async {
    try {
      state.copyWith(state: ESignInState.loading);
      if (state.formType == ESignInFormType.signIn) {
        await _reader(providerAuthRepository).signInWithEmailAndPassword(state.email, state.password);
        state.copyWith(state: ESignInState.success);
      } else if (state.formType == ESignInFormType.register) {
        await _reader(providerAuthRepository).createUserWithEmailAndPassword(state.email, state.password);
        state.copyWith(state: ESignInState.success);
      } else if (state.formType == ESignInFormType.reset) {
        await _reader(providerAuthRepository).resetPassword(state.email);
        state = SignInState.initial();
      }
    } on Failure catch (e) {
      state = SignInState.initial();
      return e;
    }
  }

  void changeFormType(ESignInFormType eSignInFormType) async {
    state = state.copyWith(formType: eSignInFormType, email: '', password: '');
  }

  void changeValue({String? email, String? password}) {
    state = state.copyWith(email: email, password: password);
  }
}
