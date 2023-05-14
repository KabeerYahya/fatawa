import 'package:flutter/material.dart';
import 'package:fatwa/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fatwa/firebase_options.dart';
import 'auth.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fatawa',
      home: Auth(),
    );
  }
}
