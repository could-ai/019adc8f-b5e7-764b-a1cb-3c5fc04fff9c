class Person {
  final String id;
  String name;
  bool isPresent;

  Person({
    required this.id,
    required this.name,
    this.isPresent = false,
  });

  // Copia para inmutabilidad parcial si fuera necesario
  Person copyWith({
    String? id,
    String? name,
    bool? isPresent,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }
}
