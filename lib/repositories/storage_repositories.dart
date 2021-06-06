import 'dart:typed_data';

import 'package:authentication_riverpod/controlers/auth/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

final providerStorageRepositories = Provider<StorageRepositories>((ref) => StorageRepositories(ref.read));

class StorageRepositories {
  final Reader _read;

  StorageRepositories(this._read);

  Future<String> uploadToFirebaseStorage({required Uint8List uint8List, required String folderName, required String name}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String uid = _read(providerAuthController).user!.uid;

    String filePath = folderName == 'accounts' ? '$folderName/$uid/avatar/$uid' : '$folderName/$name';

    try {
      await storage.ref(filePath).putData(uint8List);
    } on firebase_core.FirebaseException catch (e) {}

    return await storage.ref(filePath).getDownloadURL();
  }
}
