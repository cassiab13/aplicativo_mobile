import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AbstractService<T> {
  final String url = "http://localhost:3000";
  final String _recurso;
  final http.Client httpClient;

  AbstractService(this._recurso, this.httpClient);

  Future<List<T>> getAll() async {
    var response = await httpClient.get(Uri.parse("$url$_recurso"));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      var result = await Future.wait(jsonList.map((json) => fromJSON(json)));
      return result;
    } else {
      throw Exception('Não foi possível carregar os dados: ${response.body}');
    }
  }

  Future<String> create(T item) async {
    var response = await httpClient.post(
      Uri.parse("$url$_recurso"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: toJSON(item),
    );
    return response.body;
  }

  Future<void> update(String id, T item) async {
    var response = await httpClient.put(
      Uri.parse("$url$_recurso/$id"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: toJSON(item),
    );
    print("response: ${response.body}");
  }

  Future<void> delete(String? id) async {
    await httpClient.delete(Uri.parse("$url$_recurso/$id"));
  }

  String toJSON(T child);
  Future<T> fromJSON(dynamic json);
}
