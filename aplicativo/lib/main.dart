import 'package:aplicativo/pages/home.dart';
import 'package:aplicativo/pages/initial.dart';
import 'package:aplicativo/pages/login.dart';
import 'package:aplicativo/pages/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/initial': (context) => const InitialPage(),
      },
      );
  }
}