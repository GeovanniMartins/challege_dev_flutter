import 'package:flutter_test/flutter_test.dart';
import 'package:challege_dev_flutter/services/student_service.dart';
import 'package:challege_dev_flutter/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final uri = request.url.toString();
    if (uri.contains('/students')) {
      final response = http.Response(
        jsonEncode([
          {
            "id": "1",
            "name": "Aluno 1",
            "email": "aluno1@email.com",
            "birthdate": "2000-01-01",
            "academic_record": "0001",
            "cpf": "12345678901",
          },
        ]),
        200,
      );
      return Future.value(
        http.StreamedResponse(
          Stream.value(response.body.codeUnits),
          response.statusCode,
        ),
      );
    }
    return _inner.send(request);
  }
}

void main() {
  group('StudentService', () {
    test('fetchStudents retorna lista de aluons', () async {
      final client = MockClient();
      final service = StudentService(client: client);

      final students = await service.fetchStudents();
      expect(students, isA<List<Student>>());
      expect(students.length, greaterThanOrEqualTo(1));
      expect(students.first.name, "Alex Test");
      expect(students.first.cpf.length, 11);
    });
  });
}
