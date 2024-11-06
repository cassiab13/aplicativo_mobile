class Vaccine {
  final String name;
  final int months;
  final String? description;
  final int dose;
  bool taken;

  Vaccine({
    required this.name,
    required this.months,
    this.description,
    this.taken = false,
    required this.dose,
  });

  factory Vaccine.fromJSON(Map<String, dynamic> json) {
    return Vaccine(
      name: json['name'],
      months: json['months'],
      description: json['description'],
      dose: json['dose'],
      taken: json['taken'] ?? false,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'months': months,
      'description': description,
      'dose': dose,
      'taken': taken,
    };
  }

  String formatAge(int months) {
  if (months >= 12) {
    int years = (months / 12).floor();
    return '$years ${years == 1 ? "ano" : "anos"}';
  } else {
    return '$months ${months == 1 ? "mês" : "meses"}';
  }
}
}
