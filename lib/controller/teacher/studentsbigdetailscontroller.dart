import 'dart:convert';

import 'package:e_commerce/data/model/StudentDetailsModel/studentattendancemodel.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/model/StudentDetailsModel/studentsdetailsmodel.dart';
import 'package:e_commerce/data/datasource/remote/teacher/studentsdetailsdata.dart';

class Studentsbigdetailscontroller extends GetxController {
  List<StudentTopDetailsModel> students = [];
  List<StudentTopDetailsModel> filteredStudents = [];
  List<StudentTopDetailsModel> originalStudents = []; // نسخة عميقة من البيانات الأصلية

  List<String> subjectsNames = [];
  String selectedMaterial = "";
  Statusrequest statusrequest = Statusrequest.none;
  StudentsDetailsData studentdata = StudentsDetailsData(Get.find());

  String searchQuery = "";
  String gradeFilter = "none"; // options: none, final, oral, exam, present

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void changeMaterial(String newMaterial) {
    selectedMaterial = newMaterial;
    applyFilters();
    update();
  }

  void updateSearch(String query) {
    searchQuery = query;
    applyFilters();
    update();
  }

  void changeGradeFilter(String newFilter) {
    gradeFilter = newFilter;
    applyFilters();
    update();
  }

  void applyFilters() {
    // فلترة الاسم
    filteredStudents = students.where((student) {
      return student.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // فلترة حسب نوع الدرجة
    switch (gradeFilter) {
      case 'final':
        filteredStudents.sort((a, b) => _getFinalGrade(b).compareTo(_getFinalGrade(a)));
        break;
      case 'oral':
        filteredStudents.sort((a, b) => _getSubject(b).oralGrade.compareTo(_getSubject(a).oralGrade));
        break;
      case 'exam':
        filteredStudents.sort((a, b) => _getSubject(b).examGrade.compareTo(_getSubject(a).examGrade));
        break;
      case 'present':
        filteredStudents.sort((a, b) => _getSubject(b).numberofpresent.compareTo(_getSubject(a).numberofpresent));
        break;
      case 'none':
      default:
        // بدون ترتيب معين
        break;
    }
  }

  Subject _getSubject(StudentTopDetailsModel student) {
    return student.subjects.firstWhere(
      (s) => s.subjectName == selectedMaterial,
      orElse: () => Subject(
        subjectName: '',
        subjectId: 0,
        oralGrade: 0,
        examGrade: 0,
        homeworkGrade: 0,
        attendancegrade: 0,
        numberofpresent: 0,
        numberofabsent: 0,
        numberoflate: 0,
        numberofearlyleave: 0,
      ),
    );
  }

  int _getFinalGrade(StudentTopDetailsModel student) {
    final s = _getSubject(student);
    return s.oralGrade + s.examGrade + s.homeworkGrade + s.attendancegrade;
  }

  // دالة لجلب البيانات مع حفظ نسخة أصلية عميقة
  getData() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await studentdata.getdata();

    if (response != null && response is Map<String, dynamic>) {
      statusrequest = handlingData(response);

      if (statusrequest == Statusrequest.success) {
        var data = response['data'] as List?;

        if (data != null && data.isNotEmpty) {
          students = data.map((studentData) {
            var studentInfo = studentData[0];
            var attendanceData = studentData[1];
            var subjectsData = studentData[2];

            List<Subject> subjects = (subjectsData as List)
                .map((subjectJson) => Subject.fromJson(subjectJson))
                .toList();

            List<StudentAttendanceModel> attendances = (attendanceData as List)
                .map((att) => StudentAttendanceModel.fromJson(att))
                .toList();

            return StudentTopDetailsModel(
              id: studentInfo['student_id'],
              name: studentInfo['name'] ?? "Unknown",
              parentName: studentInfo['parent_name'],
              parentPhone: studentInfo['parent_phone'],
              subjects: subjects,
              attendances: attendances,
            );
          }).toList();

          // خزن نسخة عميقة من الطلاب الأصليين
          originalStudents = students.map((s) => s.copy()).toList();

          if (students.isNotEmpty) {
            subjectsNames = students[0].subjects.map((s) => s.subjectName).toList();
            selectedMaterial = subjectsNames.isNotEmpty ? subjectsNames.first : "";
          }

          applyFilters();
        } else {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  // دالة لإعادة تعيين درجات طالب إلى القيم الأصلية
 void resetStudentGrades(int studentId) {
  final original = originalStudents.firstWhere((s) => s.id == studentId, orElse: () => StudentTopDetailsModel(
    id: 0,
    name: '',
    parentName: '',
    parentPhone: '',
    subjects: [],
    attendances: [],
  ));

  final index = students.indexWhere((s) => s.id == studentId);

  if (index != -1 && original.id != 0) {
    final student = students[index];
    final subjectIndex = student.subjects.indexWhere((s) => s.subjectName == selectedMaterial);
    final originalSubject = original.subjects.firstWhere((s) => s.subjectName == selectedMaterial, orElse: () => Subject(
      subjectName: '',
      subjectId: 0,
      oralGrade: 0,
      examGrade: 0,
      homeworkGrade: 0,
      attendancegrade: 0,
      numberofpresent: 0,
      numberofabsent: 0,
      numberoflate: 0,
      numberofearlyleave: 0,
    ));

    if (subjectIndex != -1) {
      student.subjects[subjectIndex].oralGrade = originalSubject.oralGrade;
      student.subjects[subjectIndex].examGrade = originalSubject.examGrade;
      student.subjects[subjectIndex].homeworkGrade = originalSubject.homeworkGrade;
    }

    applyFilters();
    update();
  }
}

int getOriginalGrade(int studentId, String subjectName, String gradeType) {
  final originalStudent = originalStudents.firstWhere(
    (s) => s.id == studentId,
    orElse: () => StudentTopDetailsModel(id: 0, name: '', parentName: '', parentPhone: '', subjects: [], attendances: []),
  );

  if (originalStudent.id == 0) return 0;

  final subject = originalStudent.subjects.firstWhere(
    (s) => s.subjectName == subjectName,
    orElse: () => Subject(
      subjectName: '',
      subjectId: 0,
      oralGrade: 0,
      examGrade: 0,
      homeworkGrade: 0,
      attendancegrade: 0,
      numberofpresent: 0,
      numberofabsent: 0,
      numberoflate: 0,
      numberofearlyleave: 0,
    ),
  );

  switch (gradeType) {
    case "oralGrade":
      return subject.oralGrade;
    case "examGrade":
      return subject.examGrade;
    case "homeworkGrade":
      return subject.homeworkGrade;
    default:
      return 0;
  }
}




//to set all marks: 
Future<void> submitAllGrades() async {
  statusrequest = Statusrequest.loading;
  update();

  try {
    List<Map<String, dynamic>> payload = [];

    for (var student in students) {
      List<Map<String, dynamic>> studentMaterials = [];

      for (var subject in student.subjects) {
        studentMaterials.add({
          "subject_id": subject.subjectId,
          "oral_grade": subject.oralGrade,
          "exam_grade": subject.examGrade,
          "homework_grade": subject.homeworkGrade,
        });
      }

      payload.add({
        "student_id": student.id,
        "material": studentMaterials,
      });
    }

    var response = await studentdata.sendallgradeforallstudents(payload);

    if (response != null && response is Map<String, dynamic>) {
      statusrequest = handlingData(response);

      if (statusrequest == Statusrequest.success) {
        // You can optionally show a success message or log something
        print("Grades submitted successfully.");
      } else {
        print("Submission failed.");
      }
    } else {
      statusrequest = Statusrequest.failure;
      print("Unexpected response.");
    }
  } catch (e) {
    statusrequest = Statusrequest.failure;
    print("Error occurred while submitting grades: $e");
  }

  update();
}












}
