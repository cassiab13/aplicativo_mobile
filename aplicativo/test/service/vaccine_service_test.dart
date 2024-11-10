import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:aplicativo/models/vaccine.dart';
import 'package:aplicativo/service/vaccine_service.dart';

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late HttpClientMock httpClientMock;
  late VaccineService vaccineService;

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://localhost:3000/vaccines'));
    httpClientMock = HttpClientMock();
    vaccineService = VaccineService(httpClient: httpClientMock);
  });

  test('should get vaccines successfully', () async {
    when(() => httpClientMock.get(any())).thenAnswer(
      (_) async => http.Response(
        jsonEncode([
          {
            'id': '1',
            'name': 'BCG',
            'months': 0,
            'description': 'Uma descrição',
            'dose': 1,
            'taken': true
          },
          {
             'id': '1',
            'name': 'DTPa',
            'months': 0,
            'description': 'Uma descrição',
            'dose': 1,
            'taken': true
          },
        ]),
        200,
      ),
    );

    final vaccines = await vaccineService.getVaccines();
    expect(vaccines, isA<List<Vaccine>>());
    expect(vaccines.length, 2);
    expect(vaccines[0].name, 'BCG');
    expect(vaccines[1].name, 'DTPa');
    verify(() => httpClientMock.get(Uri.parse("http://localhost:3000/vaccines"))).called(1);
  });
}
