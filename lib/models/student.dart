class Student {
  final String id;
  final String name;
  final String email;
  final String birthdate;
  final String academicRecord;
  final String cpf;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.birthdate,
    required this.academicRecord,
    required this.cpf,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdate: json['birthdate'],
      academicRecord: json['academic_record'],
      cpf: json['cpf'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthdate': birthdate,
      'academic_record': academicRecord,
      'cpf': cpf,
    };
  }
}
