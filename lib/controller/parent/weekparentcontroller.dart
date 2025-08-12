import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/teacher/weekdata.dart';
import 'package:e_commerce/data/model/Weekmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Weekparentcontroller extends GetxController {
  final String childrenId;
  Weekparentcontroller(this.childrenId);
// Method to parse the time string into TimeOfDay
  TimeOfDay parseTime(String time) {
    final format = DateFormat("h:mm a", "en"); // AM/PM format
    final dateTime = format.parse(time);
    return TimeOfDay(hour:dateTime.hour, minute: dateTime.minute);
  }

  // Get the lesson state for each lesson based on current time
  String getLessonState(String dayName, String startTime) {
    final now = DateTime.now(); // Get the current date and time
    String currentDay = DateFormat('EEEE', 'en').format(now); // Get the current day in English

    // Translate the day from English to Arabic
    Map<String, String> daysTranslate = {
      'Sunday': 'الأحد',
      'Monday': 'الاثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
    };

    currentDay = daysTranslate[currentDay] ?? currentDay;

    // Days of the week in Arabic
    const weekDays = ['الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
    final todayIndex = weekDays.indexOf(currentDay);
    final lessonDayIndex = weekDays.indexOf(dayName);

    // If the lesson is on Saturday, it is always upcoming
    if (currentDay == 'السبت') return 'قادم';

    // If the lesson day is before today, it's terminated
    if (lessonDayIndex < todayIndex) return 'منتهي';

    // If the lesson day is after today, it's upcoming
    if (lessonDayIndex > todayIndex) return 'قادم';

    // At this point, we know the lesson is today, so we need to check the times
    final nowInMinutes = now.hour * 60 + now.minute;
    final start = parseTime(startTime);
    final startInMinutes = start.hour * 60 + start.minute;

    final todayLessons = weekschedule[dayName] ?? [];

    // Loop over the lessons for the day to determine their status
    for (var lesson in todayLessons) {
      final lessonStart = parseTime(lesson.time);
      final lessonStartInMinutes = lessonStart.hour * 60 + lessonStart.minute;
      final lessonEndInMinutes = lessonStartInMinutes + 45; // Each lesson lasts 45 minutes

      // Check if the current time is within the lesson's time range
      if (nowInMinutes >= lessonStartInMinutes && nowInMinutes < lessonEndInMinutes) {
        // If the lesson is currently ongoing, mark it as "نشط" (Active)
        if (lesson.time == startTime) {
          return 'نشط';
        }
      }
    }

    // If the current time is before the lesson starts, it's upcoming
    if (nowInMinutes < startInMinutes) {
      return 'قادم';
    }

    // If none of the above, it's terminated
    return 'منتهي';
  }

  Weekdata weekdata = Weekdata(Get.find());
  late Statusrequest statusrequest;


  // جدول الأسبوع
  Map<String, List<Weekmodel>> weekschedule = {};

  // جدول الامتحانات
  Map<String, Weekmodel> examSchedule = {};

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await weekdata.getdataForParent(childrenId);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response['data'] == null) {
        statusrequest = Statusrequest.none;
      } else {
        final data = response['data'];

    
    

        // ترتيب الأيام
        List<String> orderedDays = [
          'الأحد',
          'الاثنين',
          'الثلاثاء',
          'الأربعاء',
          'الخميس'
        ];

        // استخراج وترتيب جدول الأسبوع
        Map<String, dynamic> rawWeek = data;
        
        weekschedule = {
          for (var day in orderedDays)
            if (rawWeek.containsKey(day))
              day: List<Weekmodel>.from(
                rawWeek[day].map((e) => Weekmodel.fromJson(e)),
              )
        };

        
     
       
      }
    }
    update();
  }
}
