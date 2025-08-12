import 'package:e_commerce/controller/parent/examparentcontroller.dart';
import 'package:e_commerce/core/class/handlingdataview.dart';
import 'package:e_commerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Examsceduleparent extends StatelessWidget {
  final String childrenId;
  Examsceduleparent({super.key, required this.childrenId});

  final Map<String, String> arabicMonths = const {
    'January': 'كانون الثاني',
    'February': 'شباط',
    'March': 'آذار',
    'April': 'نيسان',
    'May': 'أيار',
    'June': 'حزيران',
    'July': 'تموز',
    'August': 'آب',
    'September': 'أيلول',
    'October': 'تشرين الأول',
    'November': 'تشرين الثاني',
    'December': 'كانون الأول'
  };

  final List<String> arabicWeekdays = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  String getArabicDay(DateTime date) {
    int index = date.weekday - 1;
    return arabicWeekdays[index];
  }

  @override
  Widget build(BuildContext context) {
    Examparentcontroller controller = Get.put(Examparentcontroller(childrenId));

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        title: const Text("جدول الامتحانات"),
      ),
      body: GetBuilder<Examparentcontroller>(
        builder: (controller) {
          return Handlingdataview(
            statusrequest: controller.statusrequest!,
            widget: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                var exam = controller.data[index];
                DateTime date = DateTime.parse(exam['date']);
                String monthName = arabicMonths[DateFormat('MMMM').format(date)] ?? '';
                String dayName = getArabicDay(date);

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      padding: const EdgeInsets.only(right: 16, left: 16, top: 30, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.menu_book_outlined, color: Colors.purple, size: 18),
                                    const SizedBox(width: 6),
                                    const Text("المادة:",style: TextStyle(color: AppColor.color2,fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 6),
                                    Text(exam['subject'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: AppColor.color9)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const Row(
                                  children: [
                                    Icon(Icons.hourglass_bottom_outlined, color: Colors.purple, size: 18),
                                    SizedBox(width: 6),
                                    Text("المدة : 45 د",style: TextStyle(color: AppColor.color2,fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined, color: Colors.purple, size: 18),
                                    const SizedBox(width: 6),
                                    Text("اليوم : $dayName",style: TextStyle(color: AppColor.color2,fontWeight: FontWeight.w600),)
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_outlined, color: Colors.purple, size: 18),
                                    const SizedBox(width: 6),
                                    Text("الوقت : ${exam['time']}" ,style: TextStyle(color: AppColor.color2,fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 16,
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${date.day}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.purple)),
                            Text(monthName, style: const TextStyle(fontSize: 12, color: Colors.purple)),
                            Text('${date.year}', style: const TextStyle(fontSize: 10, color: Colors.purple)),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
