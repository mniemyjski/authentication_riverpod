import 'package:authentication_riverpod/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum EAuthState { unknown, loading, unauthenticated, uncreated, created }

class AuthState extends Equatable {
  AuthState({
    this.status = EAuthState.unknown,
    this.user,
    this.account,
    this.failure,
  });

  final EAuthState status;
  final User? user;
  final Account? account;
  final Failure? failure;

  @override
  List<Object?> get props => [user, account, status, failure];

  factory AuthState.unknown() {
    return AuthState();
  }

  factory AuthState.loading() {
    return AuthState(
      status: EAuthState.loading,
    );
  }

  factory AuthState.unauthenticated() {
    return AuthState(
      status: EAuthState.unauthenticated,
    );
  }

  // factory AuthState.authenticated({required User? user}) {
  //   return AuthState(
  //     user: user,
  //     status: EAuthState.authenticated,
  //   );
  // }

  factory AuthState.uncreated({required User? user}) {
    return AuthState(
      user: user,
      status: EAuthState.uncreated,
    );
  }

  factory AuthState.created({required User? user}) {
    return AuthState(
      user: user,
      status: EAuthState.created,
    );
  }

  AuthState copyWith({
    EAuthState? status,
    User? user,
    Account? account,
    Failure? failure,
  }) {
    if ((status == null || identical(status, this.status)) &&
        (user == null || identical(user, this.user)) &&
        (account == null || identical(account, this.account)) &&
        (failure == null || identical(failure, this.failure))) {
      return this;
    }

    return new AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      account: account ?? this.account,
      failure: failure ?? this.failure,
    );
  }
}
