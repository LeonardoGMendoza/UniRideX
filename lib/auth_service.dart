import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Retorna o usuário atual
  User? get currentUser => _auth.currentUser;

  // Stream para escutar se o usuário logou ou deslogou
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 1. Login com E-mail e Senha
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // 2. Cadastro com E-mail e Senha
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // 3. Sair do App (Logout)
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
