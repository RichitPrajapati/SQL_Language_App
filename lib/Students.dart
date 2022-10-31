class Student {
  final int? id;
  final String name;
  final int age;
  final String city;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.city,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map['id'], name: map['name'], age: map['age'], city: map['city']);
  }
}

