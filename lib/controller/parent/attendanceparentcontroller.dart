import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/parent/attendancedata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/weekdata.dart';
import 'package:e_commerce/data/model/Weekmodel.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/class/statusrequest.dart';

class AttendanceParentController extends GetxController {
  late String childrenId;

  Statusrequest statusrequest = Statusrequest.none;
  final AttendanceData attendanceData = AttendanceData(Get.find());
  final Weekdata weekdata = Weekdata(Get.find()); // بيانات جدول الأسبوعي

  List<Map<String, dynamic>> last7Days = [];
  List<int> todayValues = [];
  String? searchedDate;

  int numberOfPresent = 0;
  int numberOfAbsent = 0;
  int numberOfLate = 0;
  int numberOfEarlyLeave = 0;

  Map<String, List<Weekmodel>> weekschedule = {}; // جدول الأسبوع مع الحصص

  @override
  void onInit() {
    super.onInit();
    childrenId = Get.arguments['childrenId'];
    getWeekSchedule();
    getLast7DaysAttendance();
  }

  Future<void> getWeekSchedule() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await weekdata.getdataForParent(childrenId);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'] == null) {
        statusrequest = Statusrequest.none;
      } else {
        final data = response['data'];

        List<String> orderedDays = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];

        Map<String, dynamic> rawWeek = data;

        weekschedule = {
          for (var day in orderedDays)
            if (rawWeek.containsKey(day))
              day: List<Weekmodel>.from(
                rawWeek[day].map((e) => Weekmodel.fromJson(e)),
              )
        };
      }
    } else {
      statusrequest = Statusrequest.failure;
    }
    update();
  }

  Future<void> getLast7DaysAttendance() async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await attendanceData.getLast7Days(childrenId);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      final data = response['data'];
      last7Days = List<Map<String, dynamic>>.from(data['attendance_last_7_days']);
      numberOfPresent = data['number_of_present'];
      numberOfAbsent = data['number_of_absent'];
      numberOfEarlyLeave = data['number_of_late'];
      numberOfLate = data['number_of_early_leave'];
      todayValues.clear();
      searchedDate = null;
    } else {
      statusrequest = Statusrequest.failure;
    }
    update();
  }

  Future<void> searchAttendanceByDate(String date) async {
    statusrequest = Statusrequest.loading;
    update();

    final response = await attendanceData.getAttendanceForDate(childrenId, date);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      final dayData = response['data']['attendance_for_date'];
      todayValues = List<int>.from(dayData['attendance_values']);
      numberOfPresent = dayData['number_of_present'];
      numberOfAbsent = dayData['number_of_absent'];
      numberOfEarlyLeave = dayData['number_of_late'];
      numberOfLate = dayData['number_of_early_leave'];
      searchedDate = dayData['date'];
    } else {
      statusrequest = Statusrequest.failure;
    }
    update();
  }
}
