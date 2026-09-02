import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Se ainda estiver checando no banco de dados
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D47A1),
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        // Se o usuário TEM um login salvo, vai direto para o Mapa (Super App)
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Se NÃO tem login, vai para a Tela de Login e Cadastro
        return const LoginScreen();
      },
    );
  }
}
