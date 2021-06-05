import 'package:authentication_riverpod/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final providerAuthRepository = Provider<AuthRepository>((ref) => AuthRepository());

abstract class _BaseAuthRepository {
  Stream<User?> authStateChanges();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}

class AuthRepository extends _BaseAuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get user => _firebaseAuth.userChanges();

  User? get getCurrentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Failure(code: '1', message: 'no account select');
      final googleAuth = await googleUser.authentication;

      final userCredential = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      ));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? '');
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
