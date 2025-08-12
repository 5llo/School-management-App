class StudentSubjectGradeModel {
  final String subjectName;
  final int subjectId;
  final int oralGrade;
  final int homeworkGrade;
  final int examGrade;

  StudentSubjectGradeModel({
    required this.subjectName,
    required this.subjectId,
    required this.oralGrade,
    required this.homeworkGrade,
    required this.examGrade,
  });

  factory StudentSubjectGradeModel.fromJson(Map<String, dynamic> json) {
    return StudentSubjectGradeModel(
      subjectName: json['subject_name'],
      subjectId: json['subject_id'],
      oralGrade: json['oral_grade'],
      homeworkGrade: json['homework_grade'],
      examGrade: json['exam_grade'],
    );
  }
}
