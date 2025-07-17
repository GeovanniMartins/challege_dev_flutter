import 'package:challege_dev_flutter/models/student.dart';
import 'package:challege_dev_flutter/untils/functions.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  final List<Student> students;
  final String filter;
  final void Function(Student) onEdit;
  final void Function(Student) onDelete;

  const StudentsList({
    super.key,
    required this.students,
    required this.filter,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final filteredStudents = students.where((student) {
      final query = filter.toLowerCase();
      return student.name.toLowerCase().contains(query) ||
          student.email.toLowerCase().contains(query) ||
          student.cpf.contains(query);
    }).toList();

    if (filteredStudents.isEmpty) {
      return Center(child: Text('Aluno(s) não encontrado(s)'));
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        student.email,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'CPF: ${formatCpf(student.cpf)}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black),
                      onPressed: () => onEdit(student),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.black),
                      onPressed: () => onDelete(student),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
