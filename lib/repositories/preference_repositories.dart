import 'package:authentication_riverpod/models/models.dart';
import 'package:authentication_riverpod/utilities/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerPreferenceRepository = Provider<PreferenceRepository>((ref) => _PreferenceRepository());

abstract class PreferenceRepository {
  streamPreference(String uid);
  createPreference(Preference preference, String uid);
  updatePreference(Preference preference, String uid);
}

class _PreferenceRepository extends PreferenceRepository {
  final ref = FirebaseFirestore.instance.collection(Path.preferences()).withConverter<Preference>(
        fromFirestore: (snapshot, _) => Preference.fromMap(snapshot.data()!),
        toFirestore: (account, _) => account.toMap(),
      );

  @override
  createPreference(Preference preference, String uid) => ref.doc(uid).set(preference);

  @override
  updatePreference(Preference preference, String uid) => ref.doc(uid).set(preference);

  @override
  Stream<Preference?> streamPreference(String uid) => ref.doc(uid).snapshots().map((account) => account.data());
}
