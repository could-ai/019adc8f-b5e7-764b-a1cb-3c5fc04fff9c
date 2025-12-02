import 'package:flutter/material.dart';
import '../data/data_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataManager dataManager = DataManager();

  @override
  void initState() {
    super.initState();
    // Escuchar cambios para actualizar contadores
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
    final total = dataManager.people.length;
    final present = dataManager.presentPeople.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Grupos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStatusCard(total, present),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    icon: Icons.people,
                    title: 'Miembros',
                    subtitle: 'Administrar lista',
                    color: Colors.blue.shade100,
                    route: '/members',
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.check_circle,
                    title: 'Asistencia',
                    subtitle: 'Marcar presentes',
                    color: Colors.green.shade100,
                    route: '/attendance',
                  ),
                  _buildMenuCard(
                    context,
                    icon: Icons.groups,
                    title: 'Formar Grupos',
                    subtitle: 'Crear equipos',
                    color: Colors.orange.shade100,
                    route: '/groups',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(int total, int present) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Resumen de Asistencia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('$total', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const Text('Total'),
                  ],
                ),
                Column(
                  children: [
                    Text('$present', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                    const Text('Presentes'),
                  ],
                ),
                Column(
                  children: [
                    Text('${total - present}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                    const Text('Ausentes'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String route,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.black54),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
