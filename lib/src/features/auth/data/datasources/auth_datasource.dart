import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';



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
        throw const Failure(message: 'Falha na autenticação');
      }

      // Atualizar último login
      await _updateLastLogin(credential.user!.uid);

      // Buscar dados do usuário no Firestore
      final userDoc =
          await _firestore.collection('users').doc(credential.user!.uid).get();

      if (!userDoc.exists) {
        throw const Failure(message: 'Dados do usuário não encontrados');
      }

            return UserModel.fromMap(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      throw Failure(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw Failure(message: 'Erro inesperado: ${e.toString()}');
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
        throw const Failure(message: 'Falha ao criar usuário');
      }

      final now = DateTime.now();
      final userModel = UserModel(
        id: credential.user!.uid,
        email: email,
        name: name,
        registrationDate: now,
        lastLogin: now,
      );

      // Salvar dados do usuário no Firestore
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Failure(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw Failure(message: 'Erro inesperado: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Failure(message: 'Erro ao fazer logout: ${e.toString()}');
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
      throw Failure(message: 'Erro ao buscar usuário: ${e.toString()}');
    }
  }

  Future<void> _updateLastLogin(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'lastLogin': Timestamp.now(),
    });
  }



  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'wrong-password':
        return 'Senha incorreta';
      case 'email-already-in-use':
        return 'Este email já está em uso';
      case 'weak-password':
        return 'A senha deve ter pelo menos 6 caracteres';
      case 'invalid-email':
        return 'Email inválido';
      case 'user-disabled':
        return 'Conta desabilitada';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      case 'invalid-credential':
        return 'Credenciais inválidas';
      default:
        return 'Erro de autenticação: $code';
    }
  }
}
