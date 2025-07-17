import 'package:challege_dev_flutter/models/student.dart';
import 'package:challege_dev_flutter/pages/student_form.dart';
import 'package:challege_dev_flutter/pages/students_edit_form.dart';
import 'package:challege_dev_flutter/services/student_service.dart';
import 'package:challege_dev_flutter/widgets/students_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> _students = [];
  String _filter = '';
  bool _loading = true;

  void _onDelete(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir aluno'),
        content: Text(
          'Tem certeza que deseja excluir o aluno "${student.name}"?',
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Excluir', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await StudentService().deleteStudent(student.id);
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sucesso'),
            content: Text('Aluno excluído com sucesso!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        _fetchStudents();
      } catch (e) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text('Erro ao excluir aluno'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        _fetchStudents();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    setState(() => _loading = true);
    try {
      final students = await StudentService().fetchStudents();
      setState(() {
        _students = students;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Falha ao carregar alunos')));
    }
  }

  void _onEdit(Student student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            StudentEditForm(student: student, onSuccess: _fetchStudents),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          backgroundColor: const Color.fromARGB(255, 9, 96, 167),
          title: Text(
            'Alunos',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Buscar...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _filter = value),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: _loading
                      ? Center(child: CircularProgressIndicator())
                      : StudentsList(
                          students: _students,
                          filter: _filter,
                          onEdit: _onEdit,
                          onDelete: _onDelete,
                        ),
                ),

                FloatingActionButton.extended(
                  extendedPadding: EdgeInsets.all(16),
                  backgroundColor: const Color.fromARGB(255, 9, 96, 167),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StudentForm(onSucess: _fetchStudents),
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Adicionar aluno',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
