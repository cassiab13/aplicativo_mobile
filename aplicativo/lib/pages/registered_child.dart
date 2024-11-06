import 'package:aplicativo/components/container.dart';
import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/service/child_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisteredChild extends StatefulWidget {
  final http.Client? httpClient;

  const RegisteredChild({super.key, this.httpClient});

  @override
  State<StatefulWidget> createState() => _RegisteredChildState();
}

class _RegisteredChildState extends State<RegisteredChild> {
  late Future<List<Child>> _children;
  late ChildService _childService;

  @override
  void initState() {
    super.initState();
    _childService =
        ChildService(httpClient: widget.httpClient ?? http.Client());
    _loadChildren();
  }

  void _loadChildren() {
    _children = _childService.getAll();
  }

  Future<void> _deleteChild(String? id) async {
    await _childService.delete(id);
    setState(() {
      _loadChildren();
    });
  }

  Future<void> _editChild(String id, Child updatedChild) async {
    await _childService.update(id, updatedChild);
    setState(() {
      _loadChildren();
    });
  }

  Future<void> _showEditDialog(Child child) async {
    final TextEditingController nameController =
        TextEditingController(text: child.name);
    final TextEditingController birthDateController =
        TextEditingController(text: child.birthDate);
    String? selectedGender = child.gender;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Criança'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: birthDateController,
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(labelText: 'Sexo'),
                items: ['Masculino', 'Feminino'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final updatedChild = Child(
                  id: child.id,
                  name: nameController.text,
                  gender: selectedGender ?? child.gender,
                  birthDate: birthDateController.text,
                  vaccines: child.vaccines,
                );
                _editChild(child.id, updatedChild);
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmation(String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content:
              const Text('Você tem certeza que deseja excluir?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteChild(id);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerComponent(
        child: FutureBuilder<List<Child>>(
        future: _children,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar as informações'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma criança registrada'));
          }

          List<Child> children = snapshot.data!;

          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ExpansionTile(
                  title: Text(child.name),
                  subtitle: Text(
                      'Data de nascimento: ${child.birthDate} | Sexo: ${child.gender}'),
                  children: [
                    Column(
                      children: child.vaccines.map((vaccine) {
                        return 
                        ListTile(
                          title:Text(vaccine.name),
                          trailing: Text('Dose: ${vaccine.dose}  | ${vaccine.formatAge(vaccine.months)}'),);
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(child);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            _showDeleteConfirmation(child.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),)
    );
  }
}
