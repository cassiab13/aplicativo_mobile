import 'dart:math';
import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/service/child_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChildRegistrationForm extends StatefulWidget {
  final Function(Child) onSaveChild;
  const ChildRegistrationForm({super.key, required this.onSaveChild});

  @override
  State<StatefulWidget> createState() => _ChildRegistrationFormState();
}

class _ChildRegistrationFormState extends State<ChildRegistrationForm> {
  final TextEditingController _ctrName = TextEditingController();
  final TextEditingController _ctrBirthDate = TextEditingController();
  final ChildService _childService = ChildService(httpClient: http.Client());
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();

  void _clearForm() {
    _ctrName.clear();
    _ctrBirthDate.clear();
    setState(() {
      _selectedGender = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Insira o nome da criança'
                        : null,
                    controller: _ctrName,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(),
                      labelText: 'Digite o nome da criança',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Insira a data de nascimento'
                        : null,
                    controller: _ctrBirthDate,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      border: OutlineInputBorder(),
                      labelText: 'Digite a data de nascimento da criança',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      labelText: 'Sexo',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedGender,
                    items: ['Masculino', 'Feminino'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Selecione o sexo'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final newChild = Child(
                            id: Random().nextInt(100).toString(),
                            name: _ctrName.text,
                            gender: _selectedGender!,
                            birthDate: _ctrBirthDate.text,
                            vaccines: [],
                          );

                          try {
                            await _childService.create(newChild);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Criança salva com sucesso!')));
                            _clearForm();
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Erro ao salvar criança: $error')));
                          }
                        }
                      },
                      child: const Text('Salvar')),
                ),
              ]),
        ),
      ),
    ));
  }
}
