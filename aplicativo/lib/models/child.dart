import 'vaccine.dart';

class Child {
  final String id;
  final String name;
  final String gender;
  final String birthDate;
  late List<Vaccine> vaccines;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.vaccines,
  });

  factory Child.fromJSON(Map<String, dynamic> json) {
    var vaccinesList = (json['vaccines'] as List<dynamic>)
        .map((vaccineJson) => Vaccine.fromJSON(vaccineJson as Map<String, dynamic>))
        .toList();

    return Child(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
      vaccines: vaccinesList,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birthDate': birthDate,
      'vaccines': vaccines.map((vaccine) => vaccine.toJSON()).toList(),
    };
  }
}
