import 'package:challege_dev_flutter/models/student.dart';
import 'package:challege_dev_flutter/services/student_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StudentEditForm extends StatefulWidget {
  final Student student;
  final void Function()? onSuccess;

  const StudentEditForm({super.key, required this.student, this.onSuccess});

  @override
  State<StudentEditForm> createState() => _StudentEditFormState();
}

class _StudentEditFormState extends State<StudentEditForm> {
  final _formKey = GlobalKey<FormState>();
  late final MaskTextInputFormatter _cpfFormatter;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _cpfController;
  late final TextEditingController _academicRecordController;
  late final TextEditingController _birthDateController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
    _nameController = TextEditingController(text: widget.student.name);
    _emailController = TextEditingController(text: widget.student.email ?? '');
    _cpfController = TextEditingController(
      text: _cpfFormatter.maskText(widget.student.cpf),
    );
    _academicRecordController = TextEditingController(
      text: widget.student.academicRecord,
    );
    _birthDateController = TextEditingController(
      text: _formatBirthDate(widget.student.birthdate),
    );
  }

  String _formatBirthDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateFormat('yyyy-MM-dd').parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  String get cpf => _cpfFormatter.getUnmaskedText();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _academicRecordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await StudentService().updateStudent(
        id: widget.student.id,
        name: _nameController.text.trim(),
        birthdate: _birthDateController.text.trim(),
        cpf: _cpfFormatter.getUnmaskedText(),
        academicRecord: _academicRecordController.text.trim(),
        email: _emailController.text.trim(),
      );
      setState(() => _isLoading = false);

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Sucesso'),
          content: Text('Alterações salvas com sucesso!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      if (widget.onSuccess != null) widget.onSuccess!();
      Navigator.of(context).pop();
    } catch (e) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao atualizar aluno.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    DateTime? initialDate;
    try {
      initialDate = DateFormat(
        'dd/MM/yyyy',
      ).parseStrict(_birthDateController.text);
    } catch (_) {
      initialDate = now.subtract(Duration(days: 365 * 18));
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: const Color.fromARGB(255, 9, 96, 167),
          title: Text(
            'Editar Aluno',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do Aluno *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Obrigatório' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: _pickDate,
                  validator: (v) {
                    if (v != null && v.isNotEmpty) {
                      try {
                        DateFormat('dd/MM/yyyy').parseStrict(v);
                        return null;
                      } catch (_) {
                        return 'Formato de data inválido';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  decoration: InputDecoration(
                    labelText: 'CPF *',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_cpfFormatter],
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Obrigatório' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _academicRecordController,
                  decoration: InputDecoration(
                    labelText: 'Registro Acadêmico(RA)*',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Obrigatório' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v != null && v.isNotEmpty) {
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(v)) return 'Email inválido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                _isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              9,
                              96,
                              167,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: _submit,
                          child: Text(
                            'Salvar Alterações',
                            style: TextStyle(color: Colors.white),
                          ),
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
