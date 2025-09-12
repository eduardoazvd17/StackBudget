import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

abstract class AuthDatasource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Stream<User?> get authStateChanges;
}

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const AuthDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AppException.authenticationFailed('Firebase returned null user');
      }

      await _updateLastLogin(credential.user!.uid);

      final userDoc =
          await _firestore.collection('users').doc(credential.user!.uid).get();

      if (!userDoc.exists) {
        throw AppException.userDataNotFound(
          'User document not found in Firestore',
        );
      }

      return UserModel.fromMap(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException.fromFirebaseAuthError(e.code, e.message);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unexpectedError('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AppException.signUpFailed('Firebase returned null user');
      }

      final now = DateTime.now();
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        registrationDate: now,
        lastLogin: now,
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AppException.fromFirebaseAuthError(e.code, e.message);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.signUpFailed('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AppException.signOutFailed('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) return null;

      return UserModel.fromMap(userDoc.data()!);
    } catch (e) {
      throw AppException.getCurrentUserFailed(
        'Get current user failed: ${e.toString()}',
      );
    }
  }

  Future<void> _updateLastLogin(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'lastLogin': Timestamp.now(),
    });
  }
}
