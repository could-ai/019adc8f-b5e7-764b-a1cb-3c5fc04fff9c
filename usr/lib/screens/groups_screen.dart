import 'package:flutter/material.dart';
import '../data/data_manager.dart';
import '../models/person.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final DataManager dataManager = DataManager();
  List<List<Person>> generatedGroups = [];
  int numberOfGroups = 2;
  bool showResults = false;

  @override
  Widget build(BuildContext context) {
    final presentPeople = dataManager.presentPeople;
    final maxGroups = presentPeople.isNotEmpty ? presentPeople.length : 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Grupos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Configuración
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Configuración', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Personas presentes: ${presentPeople.length}'),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text('Cantidad de grupos: '),
                        Expanded(
                          child: Slider(
                            value: numberOfGroups.toDouble(),
                            min: 2,
                            max: maxGroups > 2 ? maxGroups.toDouble() : 2.0,
                            divisions: (maxGroups > 2 ? maxGroups - 2 : 1),
                            label: numberOfGroups.toString(),
                            onChanged: (value) {
                              setState(() {
                                numberOfGroups = value.toInt();
                                showResults = false; // Ocultar resultados anteriores si cambia config
                              });
                            },
                          ),
                        ),
                        Text('$numberOfGroups', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: presentPeople.length < 2 
                            ? null 
                            : _generateGroups,
                        icon: const Icon(Icons.shuffle),
                        label: const Text('Formar Grupos Aleatorios'),
                      ),
                    ),
                    if (presentPeople.length < 2)
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Se necesitan al menos 2 personas presentes.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Resultados
            Expanded(
              child: showResults
                  ? ListView.builder(
                      itemCount: generatedGroups.length,
                      itemBuilder: (context, index) {
                        final group = generatedGroups[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: Colors.primaries[index % Colors.primaries.length].shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Grupo ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.primaries[index % Colors.primaries.length].shade900,
                                  ),
                                ),
                                const Divider(),
                                ...group.map((p) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person, size: 16),
                                      const SizedBox(width: 8),
                                      Text(p.name, style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Icon(
                        Icons.groups_outlined,
                        size: 100,
                        color: Colors.grey.shade300,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _generateGroups() {
    final people = List<Person>.from(dataManager.presentPeople);
    people.shuffle(); // Mezclar aleatoriamente

    List<List<Person>> newGroups = List.generate(numberOfGroups, (_) => []);

    // Algoritmo de distribución equitativa
    for (int i = 0; i < people.length; i++) {
      newGroups[i % numberOfGroups].add(people[i]);
    }

    setState(() {
      generatedGroups = newGroups;
      showResults = true;
    });
  }
}
