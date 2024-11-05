import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 30),
        FilledButton(
          onPressed: () {
            Navigator.pushNamed(context, '/main');
          },
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                 const Color.fromARGB(255, 240, 177, 203)),
              fixedSize: WidgetStateProperty.all(const Size(150, 30)),
              ),
          child: const Text(
            style: TextStyle(
              color: Colors.black,
              ),
            'Login'),
        )
      ],
    );
  }
}
