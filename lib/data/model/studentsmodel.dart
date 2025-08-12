class StudentModel {
   String? name;
  final int id;
   int oralGrade;
   String ?status;

  StudentModel({
     this.name,
    required this.id,
    required this.oralGrade,
     this.status,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      id: json['student_id'], // int, not String
      oralGrade: json['oralGrade'] ??0, // int, not String
      status: json['attendanceStatus'] =='Not Specified'  ? "" : json['attendanceStatus'] ?? "", // int, not String
    );
  }
}
