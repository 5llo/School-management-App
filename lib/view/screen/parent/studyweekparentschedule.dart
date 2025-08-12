import 'package:e_commerce/controller/parent/weekparentcontroller.dart';
import 'package:e_commerce/core/constant/routes.dart';
import 'package:e_commerce/data/model/Weekmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';

class Studyweekparentschedule extends StatelessWidget {
  final String childrenId;
  const Studyweekparentschedule({super.key, required this.childrenId});

  // Initialize controller once
  @override
  Widget build(BuildContext context) {
    final Weekparentcontroller controller = Get.put(Weekparentcontroller(childrenId));

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

    String convertTimeToArabic(String time) {
      return time.replaceAll("AM", "ص").replaceAll("PM", "م");
    }

    IconData getSubjectIcon(String subject) {
      subject = subject.toLowerCase();
      if (subject.contains('رياضيات')) return Icons.calculate;
      if (subject.contains('تاريخ')) return Icons.history_edu;
      if (subject.contains('إنجليزي')) return Icons.language;
      if (subject.contains('رياضة')) return Icons.sports_baseball_sharp;
      if (subject.contains('علوم')) return Icons.eco;
      return Icons.menu_book;
    }

    return GetBuilder<Weekparentcontroller>(
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
            onRefresh: () async {
              await controller.getData();
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFF9F9F9),
              appBar: AppBar(title:Text("برنامج الدوام"),),
              body: Column(
                children: [
               //   _buildHeader(),
                  const SizedBox(height: 24),
                  _buildInfoBar(totalLessons, activeLessons, endedLessons),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.weekschedule.length,
                      itemBuilder: (context, index) {
                        final entry = controller.weekschedule.entries.elementAt(index);
                        bool isToday = entry.key == todayInArabic;
                        return _buildScheduleItem(entry, isToday, index + 1, controller, convertTimeToArabic, getSubjectIcon);
                      },
                    ),
                  ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          Text(label, style:  TextStyle(fontSize: 14, color: Colors.black54,fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    MapEntry<String, List<Weekmodel>> entry,
    bool isToday,
    int index,
    Weekparentcontroller controller,
    String Function(String) convertTimeToArabic,
    IconData Function(String) getSubjectIcon,
  ) {
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
            children: entry.value.asMap().entries.map((e) {
              return _buildLessonItem(e.value, entry.key, e.key, controller, convertTimeToArabic, getSubjectIcon);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonItem(
    Weekmodel lesson,
    String dayName,
    int index,
    Weekparentcontroller controller,
    String Function(String) convertTimeToArabic,
    IconData Function(String) getSubjectIcon,
  ) {
    String time = convertTimeToArabic(lesson.time);
    String state = controller.getLessonState(dayName, lesson.time);
    Color stateColor = state == 'نشط'
        ? Colors.green
        : (state == 'منتهي' ? Colors.grey : Colors.orange);

    return Container(
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
      //  textDirection: TextDirection.rtl,
        children: [
          CircleAvatar(
          //  backgroundColor: Colors.purple[100],
            radius: 24,
            child: Icon(getSubjectIcon(lesson.subject), size: 20, color: Colors.purple[700]),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lesson.subject,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff800080),
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  '$time | $state',
                  style: TextStyle(
                    fontSize: 12,
                    color: stateColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
