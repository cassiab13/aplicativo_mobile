import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white54,
              border: OutlineInputBorder(),
              labelText: 'Nome do usuário',
            ),
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(
          width: 250,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white54,
              border: OutlineInputBorder(),
              labelText: 'Senha',
            ),
          ),
        ),
      ],
    );
  }
}
