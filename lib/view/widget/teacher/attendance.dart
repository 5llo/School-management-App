import 'package:e_commerce/controller/teacher/schoolschedulecontroller.dart';
import 'package:e_commerce/controller/teacher/studentsdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:get/get.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.find<SchoolScheduleController>();
    final controller = Get.find<Studentsdetailscontroller>();

    final last7 = controller.attendances
        .where((a) {
          final date = DateTime.parse(a.date);
          return date.weekday != DateTime.friday && date.weekday != DateTime.saturday;
        })
        .toList()
        .reversed
        .take(7)
        .toList();

    return Column(
      children: [
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatusItem('حضور', Color.fromARGB(255, 19, 109, 12)),
              _StatusItem('متأخر', Color.fromARGB(255, 106, 245, 88)),
              _StatusItem('غائب', Colors.red),
              _StatusItem('مبرر', Colors.purple),
              _StatusItem('غير محدد', Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: last7.length,
            itemBuilder: (context, index) {
              final attendanceDay = last7[index];
              return AttendanceDayWidget(
                day: _getArabicDayName(attendanceDay.date),
                date: attendanceDay.date,
                values: attendanceDay.attendanceValues,
              );
            },
          ),
        ),
      ],
    );
  }

  String _getArabicDayName(String date) {
    final parsed = DateTime.parse(date);
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد'
    ];
    return days[(parsed.weekday - 1) % 7];
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusItem(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.cairo14),
      ],
    );
  }
}

class AttendanceDayWidget extends StatelessWidget {
  final String day;
  final String date;
  final List<int> values;

  const AttendanceDayWidget({
    required this.day,
    required this.date,
    required this.values,
    super.key,
  });

  static const Map<int, Color> statusColors = {
    1: Color.fromARGB(255, 19, 109, 12), // حضور
    2: Colors.red,                      // غياب
    3: Colors.purple,                   // مبرر
    4: Color.fromARGB(255, 106, 245, 88), // متأخر
  };

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.find<SchoolScheduleController>();
    final scheduleList = scheduleController.weekschedule[day] ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 4),
      padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          // 🔹 Header: day and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: const BoxDecoration(
                  color: AppColor.color9,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomLeft: Radius.circular( 200),
                  ),
                ),
                child: Text(day, style: AppTextStyles.cairo14.copyWith(color: Colors.white)),
              ),
              Text(date, style: AppTextStyles.cairo14),
            ],
          ),
          const SizedBox(height: 12),

          // 🔹 Subject labels
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (i) {
              final subject = i < scheduleList.length ? scheduleList[i].subject : '';
              return Expanded(
                child: Center(
                  child: Text(
                    subject,
                    style: AppTextStyles.cairo12.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),

          // 🔹 Attendance bars
          LayoutBuilder(
            builder: (context, constraints) {
              double totalWidth = constraints.maxWidth;
              const int numLessons = 6;
              const int numSeparators = numLessons - 1;
              const double separatorWidth = 3;
              const double separatorSpacing = 3;
              const double totalSeparatorWidth = (separatorWidth + separatorSpacing * 2) * numSeparators;

              final double availableForBlocks = totalWidth - totalSeparatorWidth;
              final double blockWidth = availableForBlocks / numLessons;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(numLessons * 2 - 1, (index) {
                  if (index.isOdd) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: separatorSpacing),
                      child: Container(
                        width: separatorWidth,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 183, 180, 5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  } else {
                    final lessonIndex = index ~/ 2;
                    final statusValue = lessonIndex < values.length ? values[lessonIndex] : 0;
                    final color = statusColors[statusValue] ?? Colors.grey;

                    return Container(
                      width: blockWidth,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
