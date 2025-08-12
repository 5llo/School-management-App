import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/studentdata.dart';
import 'package:e_commerce/data/model/studentsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DayDetailsController extends GetxController {
  List<StudentModel> students = [];

  void incrementScore(int index) {
     if (students[index].oralGrade <= 19) {
      students[index].oralGrade++;
      update();
    }
  }

  void decrementScore(int index) {
    if (students[index].oralGrade > 0) {
      students[index].oralGrade--;
      update();
    }
  }

  void changeStatus(int index, String status) {
    students[index].status = status;
    update();
  }

  senddata(Map<String, dynamic> body) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await studentdata.senddatastateandoral(body);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      statusrequest = Statusrequest.success;

      Get.back();
      Get.snackbar(
        "", // No title here, we use titleText below
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        titleText: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24),
            SizedBox(width: 10),
            Text(
              "تم الحفظ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        messageText: const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(
            "تم حفظ حالة الطلاب بنجاح ",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 900),
        // forwardAnimationCurve: Curves.easeOutBack,
        // reverseAnimationCurve: Curves.easeIn,
      );
    }
    update();
  }

  void saveAttendance() async {
    List<Map<String, dynamic>> studentData = students.map((student) {
      return {
        "studentid": student.id,
        "oralgrade": student.oralGrade,
        "present": student.status == "present"
            ? 1
            : student.status == "absent"
                ? 2
                : student.status == "excused"
                    ? 3
                    : student.status == "late"
                        ? 4
                        : 0
      };
    }).toList();
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    print(parsedDate);
    Map<String, dynamic> body = {
      "date": formattedDate,
      "materailname": subject,
      "index": index - 1,
      "data": studentData,
    };

    senddata(body);
  }

  Studentdata studentdata = Studentdata(Get.find());
  late Statusrequest statusrequest;

  late String subject;
  late String day;
  late String date;
  late int index;
  late String time;

  @override
  void onInit() {
    final args = Get.arguments;
    subject = args['subject'];
    date = args['date'];
    day = args['day'];
    time = args['time'].replaceAll("AM", "ص").replaceAll("PM", "م").trim();
    args['time'];
    index = args['index'];
    getData(subject, index);
    super.onInit();
  }

  getData(String material, int index) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await studentdata.getdata(material, index, date);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'] == null) {
        statusrequest = Statusrequest.none;
      } else {
        List<dynamic> data = response['data'];
        students = data.map((e) => StudentModel.fromJson(e)).toList();
      }
    }
    update();
  }
}
