import 'package:aplicativo/components/container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text(
          'Home',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
      body: ContainerComponent(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                   Navigator.pushNamed(context, '/initial');                 
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Calendário de vacinação'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print('Clicou');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Perfil'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  print('Clicou');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Configurações'),
              ),
            ],
          ),
          ),
          );
  }
}
