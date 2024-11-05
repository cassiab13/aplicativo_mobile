import 'dart:convert';
import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/models/vaccine.dart';
import 'package:aplicativo/service/abstract_service.dart';
import 'package:aplicativo/service/vaccine_service.dart';
import 'package:http/http.dart' as http;

class ChildService extends AbstractService<Child> {
  ChildService({required http.Client httpClient}) : super('/children', httpClient);

  @override
  Future<Child> fromJSON(dynamic json) async {
    Map<String, dynamic> map = json as Map<String, dynamic>;
    List<Vaccine> vaccines = [];
    if (map['vaccines'] != null) {
      vaccines = (map['vaccines'] as List)
          .map((vaccineJson) => Vaccine.fromJSON(vaccineJson as Map<String, dynamic>))
          .toList();
    } else {
      VaccineService vaccineService = VaccineService(httpClient: http.Client());
      vaccines = await vaccineService.getVaccines();
    }

    return Child(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      birthDate: map['birthDate'],
      vaccines: vaccines,
    );
  }

  @override
  String toJSON(Child child) {
    return jsonEncode({
      'name': child.name,
      'gender': child.gender,
      'birthDate': child.birthDate,
      'vaccines': child.vaccines.map((v) => v.toJSON()).toList(),
    });
  }
}
