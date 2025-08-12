import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/studentsdetailsdata.dart';
import 'package:e_commerce/data/model/StudentDetailsModel/studentattendancemodel.dart';
import 'package:e_commerce/data/model/StudentDetailsModel/studentsdetailsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Studentsdetailscontroller extends GetxController {
  late StudentTopDetailsModel student;
  int selectedTab = 0;
  late List<Subject> tempSubjects;
  List<Subject> get subjects => tempSubjects;
  late List<StudentAttendanceModel> attendances;

  late PageController pageController;

  Statusrequest statusrequest = Statusrequest.success;
  StudentsDetailsData studentsDetailsData = StudentsDetailsData(Get.find());

  @override
  void onInit() {
    student = Get.arguments['student'];

    tempSubjects = student.subjects
        .map((s) => Subject(
              subjectName: s.subjectName,
              oralGrade: s.oralGrade,
              examGrade: s.examGrade,
              homeworkGrade: s.homeworkGrade,
              attendancegrade: s.attendancegrade,
              numberofpresent: s.numberofpresent,
              numberofabsent: s.numberofabsent,
              numberoflate: s.numberoflate,
              numberofearlyleave: s.numberofearlyleave,
              subjectId: s.subjectId,
            ))
        .toList();

    attendances = student.attendances;
    pageController = PageController(initialPage: selectedTab);

    super.onInit();
  }

  void changeTab(int index) {
    selectedTab = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
  }

  void onPageChanged(int index) {
    selectedTab = index;
    update();
  }

  void incrementOralGrade(int index) {
    if (subjects[index].oralGrade < 20) {
      subjects[index].oralGrade++;
      update();
    }
  }

  void decrementOralGrade(int index) {
    if (subjects[index].oralGrade > 0) {
      subjects[index].oralGrade--;
      update();
    }
  }

  void incrementExamGrade(int index, String gradeType) {
    if (gradeType == 'homework' && subjects[index].homeworkGrade < 20) {
      subjects[index].homeworkGrade++;
    } else if (gradeType == 'exam' && subjects[index].examGrade < 50) {
      subjects[index].examGrade++;
    }
    update();
  }

  void decrementExamGrade(int index, String gradeType) {
    if (gradeType == 'homework' && subjects[index].homeworkGrade > 0) {
      subjects[index].homeworkGrade--;
    } else if (gradeType == 'exam' && subjects[index].examGrade > 0) {
      subjects[index].examGrade--;
    }
    update();
  }

  void saveStudentMarks() async {
    statusrequest = Statusrequest.loading;
    update();

    try {
      List<Map<String, dynamic>> materialsData = subjects.map((subject) {
        return {
          "subject_id": subject.subjectId,
          "oralgrade": subject.oralGrade,
          "examgrade": subject.examGrade,
          "homeworkgrade": subject.homeworkGrade,
        };
      }).toList();

      Map<String, dynamic> body = {
        "student_id": student.id,
        "materials": materialsData,
      };

      var response = await studentsDetailsData.sendstudentsgrades(body);
      statusrequest = handlingData(response);

      if (statusrequest == Statusrequest.success) {
        Get.back(result: true);
        Get.snackbar(
          "تم الحفظ",
          "تم حفظ درجات الطالب بنجاح",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(16),
          borderRadius: 16,
          colorText: Colors.black87,
          icon: const Icon(Icons.check_circle, color: Colors.green),
        );
      }
    } catch (e) {
      statusrequest = Statusrequest.failure;
      Get.snackbar("خطأ", "حدث خطأ أثناء حفظ البيانات");
    }

    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
