import 'package:flutter/material.dart';
import '../data/data_manager.dart';
import '../models/person.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final DataManager dataManager = DataManager();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataManager.addListener(_update);
  }

  @override
  void dispose() {
    dataManager.removeListener(_update);
    _nameController.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  void _addPerson() {
    if (_nameController.text.trim().isNotEmpty) {
      dataManager.addPerson(_nameController.text.trim());
      _nameController.clear();
      Navigator.pop(context); // Cerrar el diálogo
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Persona'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: _addPerson,
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final people = dataManager.people;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Miembros'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: people.isEmpty
          ? const Center(child: Text('No hay miembros. Agrega uno.'))
          : ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(person.name.isNotEmpty ? person.name[0].toUpperCase() : '?'),
                  ),
                  title: Text(person.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Eliminar'),
                          content: Text('¿Estás seguro de eliminar a ${person.name}?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
                            TextButton(
                              onPressed: () {
                                dataManager.removePerson(person.id);
                                Navigator.pop(ctx);
                              },
                              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
