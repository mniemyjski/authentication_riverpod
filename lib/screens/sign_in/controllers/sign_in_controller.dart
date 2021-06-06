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
    state = state.copyWith(state: ETypeSignInState.loading);
    try {
      await _reader(providerAuthRepository).signInWithGoogle();
      state = state.copyWith(state: ETypeSignInState.success);
    } on Failure catch (e) {
      state = SignInState.initial();
      return e;
    }
  }

  signInWithEmail() async {
    try {
      state.copyWith(state: ETypeSignInState.loading);
      if (state.formType == ETypeSignInForm.signIn) {
        await _reader(providerAuthRepository).signInWithEmailAndPassword(state.email, state.password);
        state.copyWith(state: ETypeSignInState.success);
      } else if (state.formType == ETypeSignInForm.register) {
        await _reader(providerAuthRepository).createUserWithEmailAndPassword(state.email, state.password);
        state.copyWith(state: ETypeSignInState.success);
      } else if (state.formType == ETypeSignInForm.reset) {
        await _reader(providerAuthRepository).resetPassword(state.email);
        state = SignInState.initial();
      }
    } on Failure catch (e) {
      state = SignInState.initial();
      return e;
    }
  }

  void changeFormType(ETypeSignInForm eSignInFormType) async {
    state = state.copyWith(formType: eSignInFormType, email: '', password: '');
  }

  void changeValue({String? email, String? password}) {
    state = state.copyWith(email: email, password: password);
  }
}
