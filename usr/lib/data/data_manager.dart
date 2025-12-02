import 'package:flutter/material.dart';
import '../models/person.dart';

class DataManager extends ChangeNotifier {
  static final DataManager _instance = DataManager._internal();
  
  factory DataManager() {
    return _instance;
  }

  DataManager._internal() {
    // Datos de prueba iniciales
    _people = [
      Person(id: '1', name: 'Ana García', isPresent: true),
      Person(id: '2', name: 'Carlos López', isPresent: true),
      Person(id: '3', name: 'Beatriz Méndez', isPresent: true),
      Person(id: '4', name: 'David Ruiz', isPresent: false),
      Person(id: '5', name: 'Elena Torres', isPresent: true),
      Person(id: '6', name: 'Fernando Diaz', isPresent: true),
    ];
  }

  List<Person> _people = [];

  List<Person> get people => _people;
  List<Person> get presentPeople => _people.where((p) => p.isPresent).toList();

  void addPerson(String name) {
    final newPerson = Person(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      isPresent: true, // Por defecto presente al crear
    );
    _people.add(newPerson);
    notifyListeners();
  }

  void removePerson(String id) {
    _people.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void toggleAttendance(String id) {
    final index = _people.indexWhere((p) => p.id == id);
    if (index != -1) {
      _people[index].isPresent = !_people[index].isPresent;
      notifyListeners();
    }
  }

  void updateName(String id, String newName) {
    final index = _people.indexWhere((p) => p.id == id);
    if (index != -1) {
      _people[index].name = newName;
      notifyListeners();
    }
  }
}
