import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/pages/child_registration.dart';
import 'package:aplicativo/pages/registered_child.dart';
import 'package:aplicativo/pages/vaccines.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override
  State<StatefulWidget> createState() => _TabBarState();
}

class _TabBarState extends State<InitialPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<Child> _registeredChild = [];

  void _addChild(Child child) {
    setState(() {
      _registeredChild.add(child);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 153, 193, 227),
        title: const Text('Calendário de vacinação'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.add), text: 'Registrar criança'),
            Tab(icon: Icon(Icons.list), text: 'Crianças registradas'),
            Tab(icon: Icon(Icons.vaccines), text: 'Visualizar vacinas')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChildRegistrationForm(onSaveChild: _addChild),
          const RegisteredChild(),
          Vaccines(),
        ],
      ),
    );
  }
}
