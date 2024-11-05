import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aplicativo/models/vaccine.dart';

class VaccineService {
  final String url = "http://localhost:3000/vaccines";
  final http.Client httpClient;

  VaccineService({required this.httpClient});

Future<List<Vaccine>> getVaccines() async {
  var response = await httpClient.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Vaccine.fromJSON(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Erro ao carregar vacinas');
  }
}
}
