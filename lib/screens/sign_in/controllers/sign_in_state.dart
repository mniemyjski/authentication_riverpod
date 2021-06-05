import 'package:authentication_riverpod/models/failure_model.dart';
import 'package:equatable/equatable.dart';

enum ESignInState { initial, loading, success }
enum ESignInFormType { initial, signIn, register, reset }

class SignInState extends Equatable {
  SignInState({
    required this.email,
    required this.password,
    required this.state,
    required this.formType,
    this.failure,
  });

  final String email;
  final String password;
  final ESignInState state;
  final ESignInFormType formType;
  final Failure? failure;

  @override
  List<Object?> get props => [email, password, state, formType, failure];

  factory SignInState.initial() {
    return SignInState(
      email: '',
      password: '',
      state: ESignInState.initial,
      formType: ESignInFormType.initial,
    );
  }

  SignInState copyWith({
    String? email,
    String? password,
    ESignInState? state,
    ESignInFormType? formType,
    Failure? failure,
  }) {
    if ((email == null || identical(email, this.email)) &&
        (password == null || identical(password, this.password)) &&
        (state == null || identical(state, this.state)) &&
        (formType == null || identical(formType, this.formType)) &&
        (failure == null || identical(failure, this.failure))) {
      return this;
    }

    return new SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      state: state ?? this.state,
      formType: formType ?? this.formType,
      failure: failure ?? this.failure,
    );
  }
}
