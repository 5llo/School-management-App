class StudentBasicModel {
  final int studentId;
  final String name;
  final String? parentName;
  final String parentPhone;

  StudentBasicModel({
    required this.studentId,
    required this.name,
    required this.parentName,
    required this.parentPhone,
  });

  factory StudentBasicModel.fromJson(Map<String, dynamic> json) {
    return StudentBasicModel(
      studentId: json['student_id'],
      name: json['name'],
      parentName: json['parent_name'],
      parentPhone: json['parent_phone'],
    );
  }
}
