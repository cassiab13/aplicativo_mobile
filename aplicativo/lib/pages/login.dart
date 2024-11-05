import 'package:aplicativo/components/login_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', textAlign: TextAlign.center)
        ),
      body: const Center(
          child: 
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: 
                [
                  LoginField(),
                ],
     ),),),
    );
  }
}