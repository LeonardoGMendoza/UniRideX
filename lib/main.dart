import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import do Firebase
import 'firebase_options.dart'; // Import das chaves geradas
import 'splash_screen.dart'; 

void main() async {
  // Estas duas linhas garantem que o Firebase inicie antes de desenhar a tela
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UniRideXApp());
}

class UniRideXApp extends StatelessWidget {
  const UniRideXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniRideX',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1), 
        scaffoldBackgroundColor: Colors.white,
      ),
      // O app abre primeiro na tela de carregamento animada
      home: const SplashScreen(), 
    );
  }
}
