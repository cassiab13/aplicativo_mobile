import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/models/vaccine.dart';
import 'package:aplicativo/service/child_service.dart';
import 'package:aplicativo/service/vaccine_service.dart';

class Vaccines extends StatefulWidget {
  @override
  _VaccinesState createState() => _VaccinesState();
}

class _VaccinesState extends State<Vaccines> {
  late Future<List<Child>> _children;
  late Future<List<Vaccine>> _vaccines;
  Child? _selectedChild;
  List<Vaccine> _availableVaccines = [];
  List<Vaccine> _selectedVaccines = [];

  @override
  void initState() {
    super.initState();
    _children = ChildService(httpClient: http.Client()).getAll();
    _vaccines = VaccineService(httpClient: http.Client()).getVaccines();
  }

  void _onChildSelected(Child? child) {
    setState(() {
      _selectedChild = child;
      _selectedVaccines = child?.vaccines ?? [];
    });
  }

  void _addVaccine(Vaccine vaccine) {
    if (!_selectedVaccines.contains(vaccine)) {
      setState(() {
        _selectedVaccines.add(vaccine);
      });
    }
  }

  void _removeVaccine(Vaccine vaccine) {
    setState(() {
      _selectedVaccines.remove(vaccine);
    });
  }

  void _saveVaccines() async {
    if (_selectedChild != null) {
      _selectedChild!.vaccines.addAll(_selectedVaccines);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Vacinas adicionadas à criança ${_selectedChild!.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vacinas')),
      body: FutureBuilder<List<Child>>(
        future: _children,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar as crianças'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma criança registrada'));
          }

          List<Child> children = snapshot.data!;

          return Column(
            children: [
              DropdownButton<Child>(
                hint: const Text('Selecione uma criança'),
                value: _selectedChild,
                onChanged: _onChildSelected,
                items: children.map((child) {
                  return DropdownMenuItem<Child>(
                    value: child,
                    child: Text(child.name),
                  );
                }).toList(),
              ),
              FutureBuilder<List<Vaccine>>(
                future: _vaccines,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Erro ao carregar as vacinas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma vacina registrada'));
                  }

                  List<Vaccine> vaccines = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: vaccines.length,
                      itemBuilder: (context, index) {
                        Vaccine vaccine = vaccines[index];
                        bool isSelected = _selectedVaccines.contains(vaccine);

                        return ListTile(
                          title: Text(vaccine.name),
                          subtitle: Text('${vaccine.dose.toString()} ª dose'),
                          trailing: IconButton(
                            icon: Icon(
                              isSelected
                                  ? Icons.remove_circle
                                  : Icons.add_circle,
                              color: isSelected ? Colors.red : Colors.green,
                            ),
                            onPressed: () {
                              if (isSelected) {
                                _removeVaccine(vaccine);
                              } else {
                                _addVaccine(vaccine);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: _saveVaccines,
                child: const Text('Salvar Vacinas'),
              ),
            ],
          );
        },
      ),
    );
  }
}
