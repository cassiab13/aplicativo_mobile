import 'dart:convert';
// import 'package:aplicativo/models/child.dart';
import 'package:aplicativo/service/child_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late HttpClientMock httpClientMock;
  late ChildService childService;

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://localhost:3000'));

    httpClientMock = HttpClientMock();
    childService = ChildService(httpClient: httpClientMock);
  });
  test('should fetch children successfully', () async {
    final responseJson = [
      {
        'id': '1',
        'name': 'João',
        'gender': 'Masculino',
        'birthDate': '01-10-2023',
        'vaccines': [],
      },
      {
        'id': '2',
        'name': 'Maria',
        'gender': 'Feminino',
        'birthDate': '10-05-2021',
        'vaccines': [],
      },
    ];

      when(() => httpClientMock.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode(responseJson), 200),
      );

      final children = await childService.getAll();
      expect(children.length, 2);
      expect(children[0].name, 'João');
      expect(children[1].name, 'Maria');
    });

    test('should delete a child successfully', () async {
      const String childIdToDelete = '1';
      when(() => httpClientMock.delete(any())).thenAnswer((_) async => http.Response('', 204)); // No content for a successful delete
      await childService.delete(childIdToDelete);
      verify(() => httpClientMock.delete(
        Uri.parse("http://localhost:3000/children/$childIdToDelete"),
      )).called(1);
    });

  //   test('should update a child successfully', () async {
  //     final updatedChild = Child(
  //       id: '1',
  //       name: 'João Updated',
  //       gender: 'Masculino',
  //       birthDate: '2020-01-01',
  //       vaccines: [],
  //   );

  //   when(() => httpClientMock.put(any(), body: any(named: 'body')))
  //     .thenAnswer((_) async => http.Response('', 204));

  //   await childService.update(updatedChild.id, updatedChild);

  //   verify(() => httpClientMock.put(
  //   Uri.parse("http://localhost:3000/children/${updatedChild.id}"),
  //   body: updatedChild.toJSON(),
  //   )).called(1);
  // });
}
