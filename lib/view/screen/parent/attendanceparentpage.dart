import 'package:e_commerce/controller/parent/attendanceparentcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:e_commerce/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Attendanceparentpage extends StatelessWidget {
  const Attendanceparentpage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttendanceParentController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("الحضور والغياب"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime(2025, 12, 31),
              );
              if (selectedDate != null) {
                final formatted = DateFormat('yyyy-MM-dd').format(selectedDate);
                controller.searchAttendanceByDate(formatted);
              }
            },
          ),
        ],
      ),
      body: GetBuilder<AttendanceParentController>(
        builder: (controller) {
          return Handlingdataview(
            statusrequest: controller.statusrequest,
            widget: Column(
              children: [
                const SizedBox(height: 12),
                _StatusRow(
                  present: controller.numberOfPresent,
                  absent: controller.numberOfAbsent,
                  late: controller.numberOfLate,
                  early: controller.numberOfEarlyLeave,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: controller.todayValues.isNotEmpty && controller.searchedDate != null
                      ? ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            AttendanceDayWidget(
                              day: _getArabicDayName(DateTime.parse(controller.searchedDate!)),
                              date: controller.searchedDate!,
                              values: controller.todayValues,
                              subjects: controller.weekschedule[_getArabicDayName(DateTime.parse(controller.searchedDate!))]
                                  ?.map((e) => e.subject)
                                  .toList() ??
                                  [],
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.last7Days.length,
                          itemBuilder: (context, index) {
                            final day = controller.last7Days[index];
                            final date = DateTime.parse(day['date']);
                            final arabicDay = _getArabicDayName(date);

                            // تجاهل الجمعة والسبت
                            if (arabicDay == 'الجمعة' || arabicDay == 'السبت') {
                              return const SizedBox.shrink();
                            }

                            return AttendanceDayWidget(
                              day: arabicDay,
                              date: day['date'],
                              values: List<int>.from(day['attendance_values']),
                              subjects: controller.weekschedule[arabicDay]
                                      ?.map((e) => e.subject)
                                      .toList() ??
                                  [],
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getArabicDayName(DateTime date) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[(date.weekday - 1) % 7];
  }
}

class _StatusRow extends StatelessWidget {
  final int present;
  final int absent;
  final int late;
  final int early;

  const _StatusRow({
    required this.present,
    required this.absent,
    required this.late,
    required this.early,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatusItem('حضور: $present', const Color.fromARGB(255, 19, 109, 12)),
          _StatusItem('متأخر: $late', const Color.fromARGB(255, 106, 245, 88)),
          _StatusItem('غائب: $absent', Colors.red),
          _StatusItem('غياب مبرر : $early', Colors.purple),
        ],
      ),
    );
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
          width: 14,
          height: 14,
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
  final List<String> subjects; // أضفت هذا ليحتوي على أسماء المواد

  const AttendanceDayWidget({
    required this.day,
    required this.date,
    required this.values,
    this.subjects = const [],  // افتراضياً فارغة لو ما تم تمريرها
    super.key,
  });

  static const Map<int, Color> statusColors = {
    1: Color.fromARGB(255, 19, 109, 12), // حضور
    2: Colors.red, // غياب
    3: Colors.purple, // مبرر
    4: Color.fromARGB(255, 106, 245, 88), // متأخر
  };

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: const BoxDecoration(
                  color: AppColor.color9,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(200),
                    bottomLeft: Radius.circular(200),
                  ),
                ),
                child: Text(day, style: AppTextStyles.cairo14.copyWith(color: Colors.white)),
              ),
              Text(date, style: AppTextStyles.cairo14),
            ],
          ),
          const SizedBox(height: 12),
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
                crossAxisAlignment: CrossAxisAlignment.start, // لرفع اسم المادة فوق المكعب
                children: List.generate(numLessons * 2 - 1, (index) {
                  if (index.isOdd) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: separatorSpacing),
                      child: Container(
                        width: separatorWidth,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 183, 180, 5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  } else {
                    final lessonIndex = index ~/ 2;
                    final statusValue = lessonIndex < values.length ? values[lessonIndex] : 0;
                    final color = statusColors[statusValue] ?? Colors.grey;
                    final subjectName = lessonIndex < subjects.length ? subjects[lessonIndex] : '';

                    return SizedBox(
                      width: blockWidth,
                      child: Column(
                        children: [
                          Text(
                            subjectName,
                            style: AppTextStyles.cairo12.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
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

