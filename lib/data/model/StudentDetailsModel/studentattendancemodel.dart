class StudentAttendanceModel {
  final String date;
  final List<int> attendanceValues;

  StudentAttendanceModel({
    required this.date,
    required this.attendanceValues,
  });

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
      date: json['date'],
      attendanceValues: List<int>.from(json['attendance_values']),
    );
  }
}
