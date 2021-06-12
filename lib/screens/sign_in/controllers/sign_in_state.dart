import 'package:authentication_riverpod/models/failure_model.dart';
import 'package:equatable/equatable.dart';

enum ETypeSignInState { initial, loading, success }
enum ETypeSignInForm { initial, signIn, register, reset }

class SignInState extends Equatable {
  SignInState({
    required this.email,
    required this.password,
    this.state = ETypeSignInState.initial,
    this.formType = ETypeSignInForm.initial,
    this.failure,
  });

  final String email;
  final String password;
  final ETypeSignInState state;
  final ETypeSignInForm formType;
  final Failure? failure;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, password, state, formType, failure];

  factory SignInState.initial() {
    return SignInState(
      email: '',
      password: '',
    );
  }

  SignInState copyWith({
    String? email,
    String? password,
    ETypeSignInState? state,
    ETypeSignInForm? formType,
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
