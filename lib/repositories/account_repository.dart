import 'package:authentication_riverpod/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAccountRepository = Provider<AccountRepository>((ref) => _AccountRepository());

abstract class AccountRepository {
  streamMyAccount(String uid);
  getAccount(String id);
  createAccount(Account account);
  updateAccount(Account account);
  deleteAccount(Account account);
}

class _AccountRepository extends AccountRepository {
  final refAccount = FirebaseFirestore.instance.collection('accounts').withConverter<Account>(
        fromFirestore: (snapshot, _) => Account.fromMap(snapshot.data()!),
        toFirestore: (account, _) => account.toMap(),
      );

  @override
  createAccount(Account account) => refAccount.doc(refAccount.id).set(account);

  @override
  deleteAccount(Account account) => refAccount.doc(account.uid).delete();

  @override
  updateAccount(Account account) => refAccount.doc(refAccount.id).set(account);

  @override
  getAccount(String id) => refAccount.doc(id).get();

  @override
  Stream<Account?> streamMyAccount(String uid) => refAccount.doc(uid).snapshots().map((account) => account.data());
}
