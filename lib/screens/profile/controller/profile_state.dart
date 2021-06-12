import 'package:authentication_riverpod/models/account_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileState extends Equatable {
  final Account account;

  ProfileState({required this.account});

  factory ProfileState.initial() {
    return ProfileState(
      account: Account(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [account];
}
