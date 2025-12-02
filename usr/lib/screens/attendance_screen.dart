import 'package:flutter/material.dart';
import '../data/data_manager.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final DataManager dataManager = DataManager();

  @override
  void initState() {
    super.initState();
    dataManager.addListener(_update);
  }

  @override
  void dispose() {
    dataManager.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final people = dataManager.people;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomar Asistencia'),
      ),
      body: people.isEmpty
          ? const Center(child: Text('No hay miembros registrados.'))
          : ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return SwitchListTile(
                  title: Text(
                    person.name,
                    style: TextStyle(
                      decoration: person.isPresent ? null : TextDecoration.lineThrough,
                      color: person.isPresent ? Colors.black : Colors.grey,
                    ),
                  ),
                  subtitle: Text(person.isPresent ? 'Presente' : 'Ausente'),
                  value: person.isPresent,
                  secondary: Icon(
                    person.isPresent ? Icons.check_circle : Icons.cancel,
                    color: person.isPresent ? Colors.green : Colors.grey,
                  ),
                  onChanged: (bool value) {
                    dataManager.toggleAttendance(person.id);
                  },
                );
              },
            ),
    );
  }
}
