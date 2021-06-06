import 'package:authentication_riverpod/models/models.dart';
import 'package:equatable/equatable.dart';

enum ETypeAccountState { unknown, uncreated, created }

class AccountState extends Equatable {
  final Account? account;
  final ETypeAccountState state;

  AccountState({this.account, this.state = ETypeAccountState.unknown});

  factory AccountState.initial() {
    return AccountState();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [account, state];

  AccountState copyWith({
    Account? account,
    ETypeAccountState? state,
  }) {
    if ((account == null || identical(account, this.account)) && (state == null || identical(state, this.state))) {
      return this;
    }

    return new AccountState(
      account: account ?? this.account,
      state: state ?? this.state,
    );
  }
}
