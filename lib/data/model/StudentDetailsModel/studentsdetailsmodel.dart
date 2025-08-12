import 'package:e_commerce/data/model/StudentDetailsModel/studentattendancemodel.dart';

class StudentTopDetailsModel {
  String name;
  int id;
  String parentName;
  String parentPhone;
  List<Subject> subjects;
  List<StudentAttendanceModel> attendances;

  StudentTopDetailsModel({
    required this.name,
    required this.id,
    required this.subjects,
    required this.parentName,
    required this.parentPhone,
    required this.attendances,
  });

  factory StudentTopDetailsModel.fromJson(Map<String, dynamic> json) {
    return StudentTopDetailsModel(
      name: json['name'],
      id: json['student_id'],
      parentName: json['parent_name'],
      parentPhone: json['parent_phone'],
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
      attendances: (json['attendances'] as List)
          .map((attJson) => StudentAttendanceModel.fromJson(attJson))
          .toList(),
    );
  }

  // دالة نسخ عميقة
  StudentTopDetailsModel copy() {
    return StudentTopDetailsModel(
      name: name,
      id: id,
      parentName: parentName,
      parentPhone: parentPhone,
      subjects: subjects.map((s) => s.copy()).toList(),
      attendances: List<StudentAttendanceModel>.from(attendances), // Assuming immutable or add copy if needed
    );
  }
}

class Subject {
  String subjectName;
  int oralGrade;
  int homeworkGrade;
  int examGrade;
  int attendancegrade;
  int numberofpresent;
  int numberofabsent;
  int numberoflate;
  int numberofearlyleave;
  int subjectId;

  Subject({
    required this.subjectName,
    required this.oralGrade,
    required this.homeworkGrade,
    required this.examGrade,
    required this.attendancegrade,
    required this.numberofpresent,
    required this.numberofabsent,
    required this.numberoflate,
    required this.numberofearlyleave,
    required this.subjectId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['subject_name'] ?? "Unknown",
      oralGrade: json['oral_grade'] ?? 0,
      homeworkGrade: json['homework_grade'] ?? 0,
      examGrade: json['exam_grade'] ?? 0,
      attendancegrade: json['attendance_grade'] ?? 0,
      numberofpresent: json['number_of_present'] ?? 0,
      numberofabsent: json['number_of_absent'] ?? 0,
      numberoflate: json['numberoflate'] ?? 0,
      numberofearlyleave: json['numberofearlyleave'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
    );
  }

  // دالة نسخ عميقة
  Subject copy() {
    return Subject(
      subjectName: subjectName,
      oralGrade: oralGrade,
      homeworkGrade: homeworkGrade,
      examGrade: examGrade,
      attendancegrade: attendancegrade,
      numberofpresent: numberofpresent,
      numberofabsent: numberofabsent,
      numberoflate: numberoflate,
      numberofearlyleave: numberofearlyleave,
      subjectId: subjectId,
    );
  }
}
