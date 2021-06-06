import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/repositories/auth_repository.dart';
import 'package:authentication_riverpod/utilities/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAccountRepository = Provider<AccountRepository>((ref) => _AccountRepository(ref.read));

abstract class AccountRepository {
  Stream<Account?> streamMyAccount(String uid);
  Future<Account?> getAccount(String id);
  Future<bool> nameAvailable(String name);
  createAccount(Account account);
  updateAccount(Account account);
  deleteAccount(Account account);
}

class _AccountRepository extends AccountRepository {
  final Reader _read;

  _AccountRepository(this._read);

  final ref = FirebaseFirestore.instance.collection(Path.accounts()).withConverter<Account>(
        fromFirestore: (snapshot, _) => Account.fromMap(snapshot.data()!),
        toFirestore: (account, _) => account.toMap(),
      );

  @override
  createAccount(Account account) {
    ref.doc(account.uid).set(account);
  }

  @override
  deleteAccount(Account account) => ref.doc(account.uid).delete();

  @override
  updateAccount(Account account) => ref.doc(account.uid).set(account);

  @override
  Future<Account?> getAccount(String id) => ref.doc(id).get().then((value) => value.data());

  @override
  Future<bool> nameAvailable(String name) => ref.where('name', isEqualTo: name).get().then((value) => value.docs.length > 0 ? false : true);

  @override
  Stream<Account?> streamMyAccount(String uid) => ref.doc(uid).snapshots().map((account) => account.data());
}
