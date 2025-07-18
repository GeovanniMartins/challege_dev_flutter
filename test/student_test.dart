import 'package:flutter_test/flutter_test.dart';
import 'package:challege_dev_flutter/models/student.dart';

void main() {
  group('Student model', () {
    test('fromJson', () {
      final json = {
        "id": "1",
        "name": "Geovani Martins",
        "email": "geovani@gmail.com",
        "birthdate": "1993-01-01",
        "academic_record": "1234",
        "cpf": "00000000000",
      };

      final student = Student.fromJson(json);

      expect(student.id, "1");
      expect(student.name, "Geovani Martins");
      expect(student.email, "geovani@gmail.com");
      expect(student.birthdate, "1993-01-01");
      expect(student.academicRecord, "1234");
      expect(student.cpf, "00000000000");
    });

    test('toJson convert', () {
      final student = Student(
        id: "1",
        name: "Geovani Martins",
        email: "geovani@gmail.com",
        birthdate: "1993-01-01",
        academicRecord: "1234",
        cpf: "00000000000",
      );

      final json = student.toJson();

      expect(json["id"], "1");
      expect(json["name"], "Geovani Martins");
      expect(json["email"], "geovani@gmail.com");
      expect(json["birthdate"], "1993-01-01");
      expect(json["academic_record"], "1234");
      expect(json["cpf"], "00000000000");
    });
  });
}
