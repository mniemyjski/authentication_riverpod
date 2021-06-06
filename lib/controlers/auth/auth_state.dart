import 'package:authentication_riverpod/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum ETypeAuthState { unknown, unauthenticated, uncreated, created }

class AuthState extends Equatable {
  AuthState({
    this.state = ETypeAuthState.unknown,
    this.user,
    this.failure,
  });

  final ETypeAuthState state;
  final User? user;
  final Failure? failure;

  @override
  List<Object?> get props => [user, state, failure];

  factory AuthState.initial() {
    return AuthState();
  }

  AuthState copyWith({
    ETypeAuthState? state,
    User? user,
    Failure? failure,
  }) {
    if ((state == null || identical(state, this.state)) &&
        (user == null || identical(user, this.user)) &&
        (failure == null || identical(failure, this.failure))) {
      return this;
    }

    return new AuthState(
      state: state ?? this.state,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }
}
