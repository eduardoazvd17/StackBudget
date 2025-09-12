import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';
import 'package:stackbudget/src/features/profile/data/models/models.dart';

final profileDatasourceProvider = Provider<ProfileDatasource>((ref) {
  return ProfileDatasourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

abstract class ProfileDatasource {
  Future<UserModel> updateName(UpdateNameRequest request);
  Future<void> updatePassword(UpdatePasswordRequest request);
  Future<void> deleteAccount(DeleteAccountRequest request);
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const ProfileDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  @override
  Future<UserModel> updateName(UpdateNameRequest request) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw AppException.userNotAuthenticated('User not logged in');
      }

      await _firestore.collection('users').doc(user.uid).update({
        'name': request.newName,
      });

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw AppException.userDataNotFound('User document not found');
      }

      return UserModel.fromMap(userDoc.data()!);
    } on FirebaseException catch (e) {
      throw AppException.firestoreError('Failed to update name: ${e.message}');
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unexpectedError('Update name failed: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePassword(UpdatePasswordRequest request) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw AppException.userNotAuthenticated('User not logged in');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: request.currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(request.newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AppException.wrongPassword('Current password is incorrect');
      } else if (e.code == 'requires-recent-login') {
        throw AppException.reauthenticationRequired(
          'Please log in again to change your password',
        );
      }
      throw AppException.fromFirebaseAuthError(e.code, e.message);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unexpectedError(
        'Password update failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAccount(DeleteAccountRequest request) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw AppException.userNotAuthenticated('User not logged in');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: request.currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await _deleteUserData(user.uid);

      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AppException.wrongPassword('Current password is incorrect');
      } else if (e.code == 'requires-recent-login') {
        throw AppException.reauthenticationRequired(
          'Please log in again to delete your account',
        );
      }
      throw AppException.fromFirebaseAuthError(e.code, e.message);
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException.unexpectedError(
        'Account deletion failed: ${e.toString()}',
      );
    }
  }

  Future<void> _deleteUserData(String userId) async {
    final batch = _firestore.batch();

    try {
      final userDoc = _firestore.collection('users').doc(userId);
      batch.delete(userDoc);

      final transactionsQuery =
          await _firestore
              .collection('transactions')
              .where('userId', isEqualTo: userId)
              .get();

      for (final doc in transactionsQuery.docs) {
        batch.delete(doc.reference);
      }

      final monthlyTransactionsQuery =
          await _firestore
              .collection('monthlyTransactions')
              .where('userId', isEqualTo: userId)
              .get();

      for (final doc in monthlyTransactionsQuery.docs) {
        batch.delete(doc.reference);
      }

      final settingsDoc = _firestore.collection('settings').doc(userId);
      batch.delete(settingsDoc);

      await batch.commit();
    } catch (e) {
      throw AppException.firestoreError(
        'Failed to delete user data: ${e.toString()}',
      );
    }
  }
}
