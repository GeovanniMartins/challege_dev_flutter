import 'dart:convert';
import 'dart:io';
import 'package:challege_dev_flutter/models/student.dart';
import 'package:http/http.dart' as http;

class StudentService {
  static const String baseUrl =
      'https://653c0826d5d6790f5ec7c664.mockapi.io/api/v1/student';

  final http.Client client;
  StudentService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Student.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao carregar lista de alunos');
    }
  }

  Future<void> deleteStudent(String id) async {
    final url = '$baseUrl/$id';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception(
          'Aluno não encontrado, esse registro pode ter sido excluido por outro usuário',
        );
      } else {
        throw Exception('Falha ao excluir aluno');
      }
    } on SocketException {
      throw Exception('Erro de conexão. Verifique sua internet.');
    } catch (e) {
      throw Exception('Erro ao excluir aluno: $e');
    }
  }

  Future<void> addStudent({
    required String name,
    required String birthdate,
    required String cpf,
    required String academicRecord,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "birthdate": birthdate,
          "cpf": cpf,
          "academic_record": academicRecord,
          "email": email,
        }),
      );
      if (response.statusCode != 201) {
        throw Exception('Falha ao adicionar aluno');
      }
    } on SocketException {
      throw Exception('Erro de conexão. Verifique sua internet.');
    } catch (e) {
      throw Exception('Erro ao adicionar aluno: $e');
    }
  }

  Future<void> updateStudent({
    required String id,
    required String name,
    required String birthdate,
    required String email,
  }) async {
    final url = '$baseUrl/$id';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"name": name, "birthdate": birthdate, "email": email}),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar aluno');
    }
  }
}
