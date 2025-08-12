import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/data/model/Weekmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:e_commerce/controller/teacher/schoolschedulecontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';

class Weekschedule extends StatelessWidget {
  final SchoolScheduleController controller = Get.put(SchoolScheduleController());

  Weekschedule({super.key});

  String convertTimeToArabic(String time) {
    return time.replaceAll("AM", "ص").replaceAll("PM", "م");
  }

  IconData getSubjectIcon(String subject) {
    subject = subject.toLowerCase();
    if (subject.contains('رياضيات')) return Icons.calculate;
    if (subject.contains('فيزياء')) return Icons.science;
    if (subject.contains('لغة')) return Icons.language;
    if (subject.contains('كيمياء')) return Icons.biotech;
    if (subject.contains('علوم')) return Icons.eco;
    return Icons.menu_book;
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('EEEE', 'en_US').format(DateTime.now());
    Map<String, String> daysTranslate = {
      'Sunday': 'الأحد',
      'Monday': 'الاثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
    };
    String todayInArabic = daysTranslate[today] ?? today;

    return GetBuilder<SchoolScheduleController>(
      builder: (_) {
        int totalLessons = controller.weekschedule.values.fold(0, (sum, list) => sum + list.length);
        int activeLessons = 0;
        int endedLessons = 0;

        controller.weekschedule.forEach((day, lessons) {
          for (var lesson in lessons) {
            String state = controller.getLessonState(day, lesson.time);
            if (state == 'نشط') {
              activeLessons++;
            } else if (state == 'منتهي') {
              endedLessons++;
            }
          }
        });

        return Handlingdataview(
          statusrequest: controller.statusrequest,
          widget: RefreshIndicator(
            onRefresh: ()async {await controller.getData();  },
            child: Scaffold(
              backgroundColor: const Color(0xFFF9F9F9),
              body: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildInfoBar(totalLessons, activeLessons, endedLessons),
                  const SizedBox(height: 10),
                  _buildScheduleList(todayInArabic),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff800080),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Text(controller.schoolName, style: _headerTextStyle(22)),
          const SizedBox(height: 6),
          Text(
            " ${controller.className}  |   ${controller.divisionName}\nعدد الطلاب: ${controller.studentsCount}",
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMotivationBox(),
        ],
      ),
    );
  }

  Widget _buildMotivationBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "🌟 نصيحة اليوم: اجعل من كل حصة فرصة للتغيير!",
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  TextStyle _headerTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  Widget _buildInfoBar(int total, int active, int ended) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statBox("📚 الحصص", "$total"),
          _statBox("✅ النشطة", "$active"),
          _statBox("⏳ المنتهية", "$ended"),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff800080).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff800080))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildScheduleList(String todayInArabic) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.weekschedule.length,
        itemBuilder: (context, index) {
          final entry = controller.weekschedule.entries.elementAt(index);
          bool isToday = entry.key == todayInArabic;
          return _buildScheduleItem(entry, isToday, index + 1);
        },
      ),
    );
  }

  Widget _buildScheduleItem(MapEntry<String, List<Weekmodel>> entry, bool isToday, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        color: isToday ? const Color(0xfffff0f9) : Colors.white,
        elevation: 0,
        child: Theme(
          data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            childrenPadding: EdgeInsets.zero,
            initiallyExpanded: isToday,
            title: Text(
              entry.key,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isToday ? const Color(0xff800080) : Colors.black87,
              ),
            ),
            children: 
             entry.value.asMap().entries.map((e) {
  return _buildLessonItem(e.value, entry.key, e.key);
}).toList()

          ),
        ),
      ),
    );
  }

  Widget _buildLessonItem(Weekmodel lesson, String dayName, int index) {
    String time = convertTimeToArabic(lesson.time);
    String state = controller.getLessonState(dayName, lesson.time);
    Color stateColor = state == 'نشط'
        ? Colors.green
        : (state == 'منتهي' ? Colors.grey : Colors.orange);

    return InkWell(
      onTap: () {
        print('Lesson Index: $index');  // Print index of lesson item
        print('Subject: ${lesson.subject}');
        print('Day: $dayName');
        print('Date: ${lesson.date}');
        Get.toNamed(AppRoute.daydetails, arguments: {
          "subject": lesson.subject,
          "time": lesson.time,
        
          "day": dayName,
          "date": lesson.date,
          "index": index+1,
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: state == 'نشط'
              ? LinearGradient(
                  colors: [Colors.purple.shade50, Colors.purple.shade100],
                )
              : null,
          color: state != 'نشط' ? Colors.grey[100] : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xff800080),
              radius: 18,
              child: Icon(
                getSubjectIcon(lesson.subject),
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    lesson.subject,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        state == 'نشط'
                            ? Icons.check_circle
                            : state == 'منتهي'
                                ? Icons.close
                                : Icons.access_time,
                        color: stateColor,
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        state,
                        style: TextStyle(
                          fontSize: 11,
                          color: stateColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
